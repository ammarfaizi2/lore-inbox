Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130008AbRAYMYt>; Thu, 25 Jan 2001 07:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135412AbRAYMYj>; Thu, 25 Jan 2001 07:24:39 -0500
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:56141 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S130008AbRAYMY3>; Thu, 25 Jan 2001 07:24:29 -0500
Message-ID: <3A701AEB.CF4CE9C3@stud.uni-saarland.de>
Date: Thu, 25 Jan 2001 12:24:11 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: ak@suse.de, davem@redhat.com, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Basically it would accept the acks with the data in most
> cases except when the application has totally stopped
> reading and in that case it doesn't harm to ignore the
> acks. 

But it seems that that's exactly what rsync does:
It performs bulk data writes without reading. There are 32 kB in the
receive buffers, and rsync continues to write. If the process would read
some data the TCP stack would immediately recover.

RST are already processed, ACK's should be processed, but what about
URG? 

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
