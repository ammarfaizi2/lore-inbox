Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRJZFzJ>; Fri, 26 Oct 2001 01:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277656AbRJZFy7>; Fri, 26 Oct 2001 01:54:59 -0400
Received: from mail.medav.de ([213.95.12.190]:37382 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S277653AbRJZFys> convert rfc822-to-8bit;
	Fri, 26 Oct 2001 01:54:48 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan" <lung@theuw.net>
Cc: "Andre Hedrick" <andre@linux-ide.org>
Date: Fri, 26 Oct 2001 07:53:50 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.00
In-Reply-To: <Pine.LNX.4.33.0110252048260.1388-100000@narboza.theuw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: Repeatable File Corruption (ECS K7S5A w/SIS735)
Message-Id: <20011026045736.77F08106D0@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001 22:21:47 -0400 (EDT), dan wrote:

>  It is repeatable and verified on other boards of the same model.  This
>just started happening when I upgraded the system.  The following is a
>link to the ECS K7S5A board in question, the SIS735 chipset, and a

>  hda: ST36421A, ATA DISK drive
>  hdb: QUANTUM FIREBALLP LM10.2, ATA DISK drive
>  hdc: IC35L060AVER07-0, ATA DISK drive

>The problem only went away when I replaced the motherboard.  I also
>haven't had any file corruption issues running Windows2000 on the same
>hardware with the same files.  I moved all of the hardware in the original
>system to a new motherboard (ASUS A7A266)  and the problem went away.

>I have CC'd the IDE chipset maintainer because I can only assume it might
>be related.

It very likely is. The current Linux SiS IDE driver doesn't initialize
the the EIDE controller in the SiS735 (and most likely all other
ATA/100 capable members, too) correctly.

The SiS735 IDE cycle timing registers have a layout that is different
from the older predecessors!

>From my experiences, drivers taking this not into account *do* actually
work most of the time even if the timing of the layer 0 communication
protocol is wrong, but fail mysteriously sometimes. Andre needs to
update the SiS5513 code.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


