Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312291AbSCTXol>; Wed, 20 Mar 2002 18:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312290AbSCTXoW>; Wed, 20 Mar 2002 18:44:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:65500 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312291AbSCTXoL>; Wed, 20 Mar 2002 18:44:11 -0500
Importance: Normal
Sensitivity: 
To: Kurt Garloff <kurt@garloff.de>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF28EE4CAA.ECAC1BAA-ON88256B82.008212D2@boulder.ibm.com>
From: "James Washer" <washer@us.ibm.com>
Date: Wed, 20 Mar 2002 15:46:49 -0800
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
X-MIMETrack: Serialize by Router on D03NM038/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/20/2002 04:44:09 PM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=08BBE111DF11E76E8f9e8a93df938690918c08BBE111DF11E76E"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=08BBE111DF11E76E8f9e8a93df938690918c08BBE111DF11E76E
Content-type: text/plain; charset=us-ascii


Just to clarify things.

Lots of processes die from illegal op traps.. gcc, bash, make, etc... but
the instruction is ALWAYS  opcode 0x55 and is part of a subroutine preamble
in every case..  You are correct... 0x55 should not generate a trap.

Bad cpu? Hmmm, Tom has 6 different CPU's ( all p4 xeons ), on three
systems, that have this EXACT same problem.

and why does this require the system to be running smp?


 - jim

Kurt Garloff <kurt@garloff.de>@vger.kernel.org on 03/20/2002 03:26:10 PM

Sent by:    linux-kernel-owner@vger.kernel.org


To:    Tom Epperly <tepperly@llnl.gov>
cc:    Linux kernel list <linux-kernel@vger.kernel.org>
Subject:    Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell
       box



On Wed, Mar 20, 2002 at 01:35:30PM -0800, Tom Epperly wrote:
> The kernel log showed me that various standard programs such as
> /bin/sh are generating bogus illegal instruction traps on a legal
> opcode (0x55) as part of a standard function preamble. After receiving
> an illegal instruction trap on opcode (0x55), the modified kernel does
> a wbinvd() to flush the cache and a __flush_tlb() to flush the TLB
> and then retries the "illegal" opcode. The retry produces a second
> illegal instruction trap on the same legal opcode (0x55). Information
> from /var/log/messages is shown below.

The CPU is what triggers the exception.
So this sounds like a defect (or overheated) CPU to me.

OTOH, the kernel logs "invalid operand". Could you run ksymoops to get a
disassembly?
AFAICS, its a push %ebp instruction, which should not be illegal. So either
your stack is overflowing or my suspicion with the defect CPU is
applicable.

Regards,
--
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)


--0__=08BBE111DF11E76E8f9e8a93df938690918c08BBE111DF11E76E
Content-type: application/octet-stream; 
	name="C.DTF"
Content-Disposition: attachment; filename="C.DTF"
Content-transfer-encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NClZlcnNpb246IEdudVBHIHYxLjAuNiAoR05V
L0xpbnV4KQ0KQ29tbWVudDogRm9yIGluZm8gc2VlIGh0dHA6Ly93d3cuZ251cGcub3JnDQoNCmlE
OERCUUU4bVJxU3htTGg2aHlZZDA0UkFqc2VBSjlEOVdGY2hONElkV2JoL3JVY0o5QzU1UlQ2bmdD
Z2w0cDkNCkhBMVFGekRWcTJVZEw5MzlqcjJidTdVPQ0KPWpHc1kNCi0tLS0tRU5EIFBHUCBTSUdO
QVRVUkUtLS0tLQ0KDQo=

--0__=08BBE111DF11E76E8f9e8a93df938690918c08BBE111DF11E76E--

