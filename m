Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129546AbRB0RHa>; Tue, 27 Feb 2001 12:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129613AbRB0RHU>; Tue, 27 Feb 2001 12:07:20 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:61943 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S129546AbRB0RHF>;
	Tue, 27 Feb 2001 12:07:05 -0500
Message-ID: <3A9BC2A9.F5EE8554@fc.hp.com>
Date: Tue, 27 Feb 2001 10:07:21 -0500
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Camm Maguire <camm@enhanced.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 IDE tape problem, with ide-scsi
In-Reply-To: <54u25g3yb9.fsf_-_@intech19.enhanced.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Camm Maguire wrote:
> 
> The Conner gives the problem:
> 
> Feb 27 06:23:16 intech9 kernel: st0: Error with sense data: [valid=0] Info fld=0x0, Current st09:00: sns = 70  5
> Feb 27 06:23:16 intech9 kernel: ASC=20 ASCQ= 0
> Feb 27 06:23:16 intech9 kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00
> 
> and occaisional 'gunzip: unexpected end of file' errors on verifying
> the tape.
> 
> Take care,
> 
> --
> Camm Maguire                                            camm@enhanced.com

ASC/ASCQ of 0x20/0x00 means "Invalid command operation code". So the
drive is rejecting a command sent to it by the driver. If the other
drive that is working is identical to seemingly non-working one, maybe
this drive is going bad. 

st driver prints the SCSI command that may have caused this error only
when compiled with debug turned on. Maybe st driver should always print
the command that results in a check condition as long as the command is
not a Test Unit Ready or Mode Sense. 
 
====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
