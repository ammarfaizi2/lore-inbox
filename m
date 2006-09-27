Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030644AbWI0TK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030644AbWI0TK2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbWI0TK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:10:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:60993 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030644AbWI0TK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:10:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HPnQPGBL/tHOJzGAL/lS6SjybQyyBeinLDLUipVvLr7kzq/swTEHb/s2Zp7WCAe2zZVJ9kJES96IimhCKPVQWp2sx1dEloUFVzeJfus5KUYpIE4R7ArcN5lmJ82bYliuGxWDqlngS+PkhR9gn7NHwa5czqdK44FEDCyeTj+jHPY=
Message-ID: <c1bf1cf0609271210o5958e39y94e033b478e979f5@mail.gmail.com>
Date: Wed, 27 Sep 2006 12:10:26 -0700
From: "Ed Swierk" <eswierk@arastra.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [RETRY] [PATCH] load_module: no BUG if module_subsys uninitialized
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
In-Reply-To: <20060927045611.GC32644@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c1bf1cf0609221248v39113875id4b48c62cec8eb46@mail.gmail.com>
	 <20060922201637.GA17547@kroah.com>
	 <c1bf1cf0609221428i618a5902g3d0315f6b0b9b79e@mail.gmail.com>
	 <20060927045611.GC32644@kroah.com>
X-Google-Sender-Auth: 3d630fc0e9ec2d34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/06, Greg KH <greg@kroah.com> wrote:
> So, with this patch the module will still not be loaded properly, right?
> Well, I guess at least we don't oops... ok.

Correct. sys_init_module() ends up returning an error to
/sbin/modprobe, which trickles down to request_module() if it was
invoked via kmod. The module doesn't get loaded, but at least the
error message states which module it is, and as you say, at least we
don't oops.

I think that not oopsing is pretty important in a case where a goofy
but technically valid configuration (compiling Unix sockets as a
module, and trying to boot with a rootfs containing a version of
/sbin/hotplug that requires Unix sockets) collides with an obscure
kernel implementation detail (initcall ordering).

--Ed
