Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbTGIKrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268151AbTGIKrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:47:22 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:34483 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S265931AbTGIKqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:46:45 -0400
Message-ID: <3F0BF713.4080005@wipro.com>
Date: Wed, 09 Jul 2003 16:35:55 +0530
From: Arvind Kandhare <arvind.kan@wipro.com>
Reply-To: arvind.kan@wipro.com
Organization: Wipro Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jul 2003 11:01:15.0316 (UTC) FILETIME=[6A92C740:01C34609]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem can be attacked in two steps:

1. Stop new forks from being created
2. Kill the process causing the forks

The current ulimit implementation, afaik, can only control the
processes which will be created from the current moment onwards.
Ther processes which are already started will continue creating forks.
New processes created by the fork wil have this limit.

Basically it does not ensure that first step is completely executed.
So if your rate of killing is less than the processes being created and
resources are exausted, your system hangs.

There was a RFC patch  "[RFC][PATCH 2.5.70] Dynamically tunable
maxusers, maxuprc and max_pt_cnt" posted on 2003-06-06. It implements
maxuprc (maxuprc: maximum number of processes per user) as a dynamic tunable
parameter. It can be useful to overcome this problem. By setting maxuprc to a
very low value, new creation of the process is stopped. Then root can kill ('cos
this limit is not applicable to root) the erring processes.
There is no race against time as there is no chance of new process getting created once
this value is reduced.

cheers ..
Arvind ...







