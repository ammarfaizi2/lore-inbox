Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVFAQVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVFAQVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVFAQVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 12:21:42 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:63139 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261451AbVFAQV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 12:21:29 -0400
Message-ID: <429DE087.606@gmx.de>
Date: Wed, 01 Jun 2005 18:21:27 +0200
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo> <d120d500050531122879868bae@mail.gmail.com> <429DDA07.nail7BFA4XEC5@burner>
In-Reply-To: <429DDA07.nail7BFA4XEC5@burner>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

> Think again what you like to tell me here.... You like to tell me
> cdrecord is one of thousands of bad programs but it is the first
> program that introduced stability at command line level if talking about
> generic SCSI usage. 
> 
> If somebody later develops something like udev (did not see it yet)
> I would asume that this person would look at earlyer stable software and
> provide some way of integration.

Heck. The whole issue is that cdrecord is unjustly complaining when it
is given a device node that is perfect. For my 2.6.11 system, /dev/hdd
(ATAPI hardware, ide-cd device) is as stable as it will get, yet
cdrecord complains and attempts to coerce some numbering scheme that
Linux isn't offering through /dev/*. Same story with FreeBSD, I need to
figure out some intransparent ATAPI transport identifier rather than
just using /dev/acd0.

So your first step to pull the rug from underneath most of this
discussion is just to disable this unnecessary warning for the ATA:
interface, whether it is

	Warning: Open by 'devname' is unintentional and not supported.

or

	Warning: Using badly designed ATAPI via /dev/hd* interface.

This is your personal vendetta against Linux device naming or numbering,
 hence policy, and not a technical reason to complain. Particularly, if
cdrecord can use the device node, it MUST not print a warning, if you
think it's intentional or not.

Please remove these two warnings and you'll see a considerable part of
the discussion end.

ATAPI: is a different story, if the device doesn't support DMA (ide-scsi
bugs), that's a serious reason to avoid it, and the warning is justified.

-- 
Matthias Andree
