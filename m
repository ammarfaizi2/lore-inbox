Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVBCAEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVBCAEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVBBXwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:52:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16821 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262683AbVBBXuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:50:20 -0500
Date: Wed, 2 Feb 2005 23:50:02 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Christophe Saout <christophe@saout.de>,
       Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de
Subject: Re: dm-crypt crypt_status reports key?
Message-ID: <20050202235002.GD14097@agk.surrey.redhat.com>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christophe Saout <christophe@saout.de>,
	Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de
References: <20050202211916.GJ2493@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202211916.GJ2493@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 01:19:16PM -0800, Matt Mackall wrote:
> # dmsetup table /dev/mapper/volume1
> 0 2000000 crypt aes-plain 0123456789abcdef0123456789abcdef 0 7:0 0
 
> Obviously, root can in principle recover this password from the
> running kernel but it seems silly to make it so easy.
 
There seemed little point obfuscating it - someone will only
write a trivial utility that recovers it.

The current approach has the advantage of making it
obvious to you that if you have root access, you have
access to the password while the encrypted data volumes
are mounted.

Consider instead *why* you're worried about the password being
held in RAM and look for better solutions to *your*
perceived threats.


Threat: Someone could run "dmsetup" while I've gone for a coffee 
break leaving my laptop unattended logged on as root...


Threat: My laptop is stolen while it's got a screen saver running
(or suspended) and the thief could interrogate RAM and get the 
password, giving them access to my encrypted data volumes.

Possible fixes: Automatically unmount those volumes before
starting the screen saver.  Automatically unmount them
after a certain amount of inactivity.  Require the password
to be re-entered at regular intervals.  New risks: regular
entry of password means more chance of its being observed,
so consider one-time passwords to gain access to it, or
USB dongle periodically inserted etc. etc. 

Alasdair
-- 
agk@redhat.com
