Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265141AbUEZEnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUEZEnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbUEZEnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:43:23 -0400
Received: from [213.171.41.46] ([213.171.41.46]:44292 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S265141AbUEZEnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:43:20 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
Organization: MySQL AB
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
Date: Wed, 26 May 2004 08:43:17 +0400
User-Agent: KMail/1.6.2
Cc: linuxram@us.ibm.com, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
References: <200405022357.59415.alexeyk@mysql.com> <20040520145902.27647dee.akpm@osdl.org> <200405220113.31136.alexeyk@mysql.com>
In-Reply-To: <200405220113.31136.alexeyk@mysql.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405260843.17682.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 May 2004 01:13, Alexey Kopytov wrote:
>I ran the tests with a configuration as close to yours as possible. Here are
>the results for mem=256M, 2G total file size (ext3):
>
>2.4.25:
>       Time spent for test:  79.4146s
>                0.20user 16.08system 3:20.29elapsed 8%CPU
>       Time spent for test:  78.9797s
>                0.11user 15.84system 3:19.76elapsed 7%CPU
>
>2.6.6-bk, AS:
>       Time spent for test:  81.2208s
>                0.13user 17.97system 3:13.30elapsed 9%CPU
>       Time spent for test:  82.5538s
>                0.14user 18.00system 3:14.88elapsed 9%CPU
>
>This correlates very well your results. But when I returned back to my
>original configuration (mem=640M, 3G total file size), I got the following:
>
>2.4.25:
>       Time spent for test:  77.5377s
>
>2.6.6-bk, AS:
>       Time spent for test:  83.1929s
>
>It seems like the smaller file size just hides the regression, but I have to
>run some more tests to ensure this.
>

The assumption appears to be true. I tried to vary the total file size and got 
the following results (tests were done on another IDE disk):

2.4.27-pre3:
    2 GB:  58.2707s
    4 GB:  72.3313s
    8 GB:  83.082s

2.6.7-rc1, AS:
    2 GB:  60.6792s  
    4 GB:  82.8023s
    8 GB:  99.4398s

Varying the number of files while keeping the total file size constant also 
gives some interesting results:

2.4.27-pre3, 4 GB total file size:
    1 file:  71.7288s
    128 files: 72.3313s
    256 files: 73.9268

2.6.7-rc1, AS, 4 GB total file size:
    1 file: 76.443
    128 files: 82.8023
    256 files: 81.9618

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
