Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319034AbSHMOKC>; Tue, 13 Aug 2002 10:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319035AbSHMOKC>; Tue, 13 Aug 2002 10:10:02 -0400
Received: from host194.steeleye.com ([216.33.1.194]:25609 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S319034AbSHMOKC>; Tue, 13 Aug 2002 10:10:02 -0400
Message-Id: <200208131413.g7DEDd502174@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       Erik Andersen <andersen@codepoet.org>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Aug 2002 09:13:39 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -             if (ret) {
> > +             if (ret && sense.sense_key==0x05 && sense.asc==0x20 && sense.ascq==0x00) {
> 
> Do you really need to hardcode this values ?

We have no #defines for the asc and ascq codes (they are interpreted in 
constants.c but the values are hardcoded in there too).  There is a #define 
for sense_key 0x05 as ILLEGAL_REQUEST in scsi/scsi.h, but these #defines have 
annoyed a lot of people by being rather namespace polluting.

James


