Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbTCGLfm>; Fri, 7 Mar 2003 06:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbTCGLfm>; Fri, 7 Mar 2003 06:35:42 -0500
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:5525 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S261505AbTCGLfl>; Fri, 7 Mar 2003 06:35:41 -0500
Date: Fri, 7 Mar 2003 12:46:11 +0100 (CET)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Russell King <rmk@arm.linux.org.uk>
cc: Chris Dukes <pakrat@www.uk.linux.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Robin Holt <holt@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: Make ipconfig.c work as a loadable module.
In-Reply-To: <20030307094235.A11807@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303071223480.30312-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003, Russell King wrote:

> Which version is overly bloated?
> Which version is huge?
> Which version is compact?

... and the size is not important only because we want to make everything 
smaller, but because of how it's commonly used (at least in the clustering 
world from which I come):

the mainboard BIOS or NIC PROC contains PXE/DHCP client; data is 
transferred through UDP, with very poor (if any) congestion control. 
Congestion control means here both extreme situations: if packets don't 
arrive to the client, it might not ask again, ask only a limited number of 
times or give up after some timeout; if the server has some faster NIC to 
be able to handle more such requests, it might also send too fast for a 
single client which might drop packets. In some cases, if such situation 
occurs, the client just blocks there printing an error message on the 
console, without trying to restart the whole process and the only way to 
make it do something is to press the Reset button or plug in a keyboard... 
When you have tens or hundreds of such nodes, it's not a pleasure !

Booting a bunch of such nodes would become problematic if they need 
to transfer more data (=initrd) to start the kernel and so network booting 
would become less reliable. Please note that I'm not saying "ipconfig has 
to stay" - just that any solution should not dramatically increase the 
size of data transferred before the jump to kernel code.

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

