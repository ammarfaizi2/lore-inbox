Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVDQQ1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVDQQ1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 12:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDQQ1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 12:27:14 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:56328 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261351AbVDQQ1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 12:27:11 -0400
Date: Sun, 17 Apr 2005 18:27:07 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
Message-ID: <20050417162707.GA511@pcw.home.local>
References: <4ae3c14050417085473bd365f@mail.gmail.com> <20050417160306.GB777@alpha.home.local> <4ae3c140504170912b36e9b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140504170912b36e9b1@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 12:12:13PM -0400, Xin Zhao wrote:
> Thanks for your reply. 
> 
> Yes. I know,  with immutable,  even root cannot modify sensitive
> files. What I am curious is if an intruder has root access, he may
> have many ways to turn off the immutable protection and modify files. 
> So immutable is designed just to prevent a valid root from making
> silly mistakes?

Probably yes, but it also provides a first level of security :
  - if the intruder launches programs blindly, he will not systematically
    get write access. Eg: if he abuses a CGI to call things like
      echo r00t::0:0::/:/bin/sh >>/etc/passwd
    it will not work.

  - if you give root access to other people on your file-system but you
    don't give them the CAP_LINUX_IMMUTABLE capability, they will not be
    able to modify the protected files. Useful when those files are the
    ones you use to grant them access ;-)

Regards,
Willy

