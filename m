Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWAZJwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWAZJwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 04:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWAZJwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 04:52:18 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:64714 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932259AbWAZJwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 04:52:17 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 10:50:52 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: rlrevell@joe-job.com, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D89B7C.nailDTH38QZBU@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner>
 <43D7B5BE.60304@gmx.de>
In-Reply-To: <43D7B5BE.60304@gmx.de>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Joerg Schilling wrote:
>
> >> So I'll repeat my question: is there anything that SG_IO to /dev/hd* (via
> >> ide-cd) cannot do that it can do via /dev/sg*? Device enumeration doesn't count.
> > 
> > But device enumeration is the central point when implementing -scanbus.
>
> Again: Is there anything *besides* (<German>: außer) device enumeration that
> does not work with the current /dev/hd* SG_IO interface?

This is the main point.

People like to run cdrecord -scanbus in order to find a list of usable devices.
People like to see all SCSI devices in a single name space as they are all 
using the same protocol for communication.

A sane way to send SCSI commands to _any_ type of devices would be to have a 
SCSI generic transport layer that is independent from the high-level features 
of the OS and that is independent from whether there is a high-level driver for 
this device at all.

This is what I designed the scg driver interface for in 1986 and this is what
Adaptec did in 1988 with ASPI. This is of course also why the SCSI standard 
commitee made a proposal for the CAM SCSI interface. 

http://www.t10.org/ftp/t10/drafts/cam/cam-r12b.pdf
http://www.t10.org/ftp/t10/drafts/cam3/cam3r03.pdf

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
