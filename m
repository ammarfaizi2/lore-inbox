Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVDEARy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVDEARy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 20:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVDEAQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 20:16:09 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:9817 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261458AbVDEAPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 20:15:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=k59F09IWlFgMCNQy8DdwD+6KHFiFfic3GaearsjD7CE/21KoGIEtcsso6QVVjtZCLITDJd/RzXnM5fgSqBmpYHP81TVkFWXbrCjINcX4NqVQLjAWeG+rrrYXKuxRstzFKBOn1LoZ3SZ/+L/+yEwQw6lZGg77KdVGOBt0ghxVoW4=
Message-ID: <d120d50005040417151987558d@mail.gmail.com>
Date: Mon, 4 Apr 2005 19:15:32 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jaco Kroon <jaco@kroon.co.za>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
Cc: linux-kernel@vger.kernel.org, Sebastian Piechocki <sebekpi@poczta.onet.pl>
In-Reply-To: <4251D3CB.4010501@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <425166F9.1040800@kroon.co.za>
	 <d120d5000504040954354fb3fa@mail.gmail.com>
	 <42517442.20602@kroon.co.za>
	 <d120d500050404110374fe9deb@mail.gmail.com>
	 <4251A515.8040802@kroon.co.za>
	 <d120d500050404140253a77ab8@mail.gmail.com>
	 <4251B6E2.3010506@kroon.co.za>
	 <d120d50005040415506cd87287@mail.gmail.com>
	 <4251D3CB.4010501@kroon.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 4, 2005 6:54 PM, Jaco Kroon <jaco@kroon.co.za> wrote:
> Dmitry Torokhov wrote:
> > Ok, try booting with "usb-handoff i8042.nomux". If that cures
> 
> yes, it cures both problems (death on reboot and ALPS), in fact.  But I
> must have *both* params.  nomux without usb-handoff causes all input
> devices to fail.  Thanks goodness for ssh.  Anyway - I'm now running a
> clean 2.6.11.6 kernel that *works*.
> 
> > death-on-reboot problem then Vojtech already has a patch in
> > 2.6.12-rc1:
> >
> > http://linux.bkbits.net:8080/linux-2.5/cset@41f8e2d7j4JtjbrlrI5eYgQQ86yDhg
> 
> Yes, this should fix the death-on-reboot (why oh why can't the BIOS just
> "do the right thing"), it still won't get me alps though.  For that I
> need the nomux option - ie, a total different codepath than what that
> patch attends to.  And it probably won't fix the keyboard problem.  This
> sucks (don't get me wrong - I appreciate that my hardware is now
> functioning properly - only things afaik that doesn't work now is the SD
> card reader and suspend/hibernate and with ati-drivers there is not a
> chance in hell that that'll ever work, neither of which is of critical
> importance for me).
> 
> > Yes, with 4 ports your external mouse is independent from the touhpad.
> > When you have only 1 port you can't use touchpad's extended mode
> > together with an external mouse.
> 
> No external PS/2 port :).
> 

A-haa.. Well, in that case we'll cheat ;) and just disable MUX mode
for your Toshiba via a DMI quirk, like we do for certain Fujitsus. If
there is no external port there is no reason to have the controller in
MUX mode.

Could you please send me output of 'dmidecode' utility?
 
-- 
Dmitry
