Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSGONYx>; Mon, 15 Jul 2002 09:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317468AbSGONYw>; Mon, 15 Jul 2002 09:24:52 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:9965 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S315746AbSGONYv>; Mon, 15 Jul 2002 09:24:51 -0400
Date: Mon, 15 Jul 2002 15:26:08 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200207151326.g6FDQ8nH020722@burner.fokus.gmd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As my textual description has not been read, here comes a acsii art
of the proposal for a driver structure:



			User programs

----------------------------------------------------------------
----------------------------------------------------------------
|								|
|		Kernel driver interface				|
|								|
----------------------------------------------------------------
		|				|
--------------------------------  ------------------------------
|				| |				|
|	One or more SCSI	| |	One or more simple	|
|	target drivers		| |	Block based drivers	|
|	    e.g. sd.c		| |	  e.g. dsata.c		|
|				| |				|
|				| |				|
--------------------------------  ------------------------------
		|				|
		|				|------------------ Locked when
		|				|		    SCSI glue
----------------------------------------------------------------    Interface is
|				|				|   used for a
|				|				|   specific
|	SCSI glue layer		|   Block access glue layer	|   drive.
|				|				|
|	Will check if target	|				|
|	supports SCSI commands	|				|
|	and lock Block access	|				|
|	layer in this case.	|				|
|				|				|
----------------------------------------------------------------
|								|
|			 Low level glue				|
|								|
----------------------------------------------------------------
	| SCSI CDB/IF			| SCSI CDB/IF | Block IF
--------------------------------  ------------------------------
|				| |				|
|				| |				|
|	SCSI HBA driver		| |	ATA HBA driver		|
|				| |	deals with simple ATA	|
|	Only supports		| |	interface and with	|
|	SCSI CDB interface	| |	ATA packet interface	|
|				| |				|
|				| |				|
--------------------------------  ------------------------------


All HBA drivers include DMA setup callback functions to make the
target drivers completely independant from the HW.

Communication for all types of interfaces is HW address cookie
based and done via callback.

Above the glue layer, no knowledge about SCSI disconnect/reconnect
is needed.



Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
