Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130043AbRBNUpq>; Wed, 14 Feb 2001 15:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130826AbRBNUpg>; Wed, 14 Feb 2001 15:45:36 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:11755 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130644AbRBNUpY>; Wed, 14 Feb 2001 15:45:24 -0500
Message-ID: <3A8AEDB9.59721801@sympatico.ca>
Date: Wed, 14 Feb 2001 15:42:34 -0500
From: Jeremy Jackson <jeremy.jackson@sympatico.ca>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gord R. Lamb" <glamb@lcis.dyndns.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Samba performance / zero-copy network I/O
In-Reply-To: <Pine.LNX.4.32.0102141452210.27843-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gord R. Lamb" wrote:

> Hi everyone,
>
> I'm trying to optimize a box for samba file serving (just contiguous block
> I/O for the moment), and I've now got both CPUs maxxed out with system
> load.
>
> (For background info, the system is a 2x933 Intel, 1gb system memory,
> 133mhz FSB, 1gbit 64bit/66mhz FC card, 2x 1gbit 64/66 etherexpress boards
> in etherchannel bond, running linux-2.4.1+smptimers+zero-copy+lowlatency)
>
> CPU states typically look something like this:
>
> CPU states:  3.6% user,  94.5% system,  0.0% nice, 1.9% idle
>
> .. with the 3 smbd processes each drawing around 50-75% (according to
> top).
>
> When reading the profiler results, the largest consuming kernel (calls?)
> are file_read_actor and csum_partial_copy_generic, by a longshot (about
> 70% and 20% respectively).
>
> Presumably, the csum_partial_copy_generic should be eliminated (or at
> least reduced) by David Miller's zerocopy patch, right?  Or am I
> misunderstanding this completely? :)

I only know enough to be dangerous here, but I believe you will need to
be using one of the network cards whose driver actually uses the
zero-copy patches, and/or which can perform tcp checksum in hardware
(of the network card).

