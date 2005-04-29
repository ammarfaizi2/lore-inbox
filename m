Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVD2TWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVD2TWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVD2TWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:22:38 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:51866 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262889AbVD2TWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:22:18 -0400
Message-ID: <42728964.8000501@austin.rr.com>
Date: Fri, 29 Apr 2005 14:22:12 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: which ioctls matter across filesystems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other than the obvious example of
    EXT2_IOC_GETFLAGS
and
    EXT2_IOC_SETFLAGS
which are implemented by multiple filesystems (and are necessary to 
support a few commonly used tools), are there any other ioctls which 
should be able to be sent remotely (optionally)?   For it to be worth 
extending the network protocol (in my case CIFS to servers such as 
Samba, but presumably cluster filesystems have similar interests in 
supporting all key local tools across the network), an ioctl would have 
to be
    - used by more than one local filesystem
    - not have an equivalent way to do the same thing without an ioctl

I have added the GET/SETFLAGS client support, but am not aware of any 
others which would need to be remoted.   For fcntl there are more, but 
it requires more research to figure out how to handle setlease/getlease 
and a few others with network implications without degrading 
performance.   Although I am not a fan of ioctls and fcntls, there are a 
few that are necessary to achieve 100% local semantics across the network.

The new inotify mechanism being prototyped in -mm currently is the other 
one which needs work to determine how to map it across the network.   
Since it was added for support of Samba, the corresponding client part 
(for cifs) may turn out to map to the network protocol quite well 
already, and given NFSv4 having various similarities to CIFS, it would 
be interesting if the semantics of inotify would map to NFSv4 write 
protocol.
