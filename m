Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130447AbRCGI7s>; Wed, 7 Mar 2001 03:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130451AbRCGI7j>; Wed, 7 Mar 2001 03:59:39 -0500
Received: from smtp1.libero.it ([193.70.192.51]:50337 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S130447AbRCGI7d>;
	Wed, 7 Mar 2001 03:59:33 -0500
Message-ID: <3AA5F843.F93B6D4C@alsa-project.org>
Date: Wed, 07 Mar 2001 09:58:43 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre6 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Jeremy Elson <jelson@circlemud.org>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
In-Reply-To: <200103070813.f278DUw06475@servo.isi.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Elson wrote:
> 
> Marcelo Tosatti writes:
> >On Wed, 7 Mar 2001, Alexander Viro wrote:
> >> You are reinventing the wheel.
> >> man ptrace (see PTRACE_{PEEK,POKE}{TEXT,DATA} and PTRACE_{ATTACH,CONT,DETACH})
> >
> >With ptrace data will be copied twice. As far as I understood, Jeremy
> >wants to avoid that.
> 
> Yes - I've been looking at the sys_ptrace code and it seems that it
> does two copies through the kernel (but, using access_process_vm
> instead of copy_from_user -- I'm not sure how they differ).  I'm
> trying to reduce the number of copies by giving one process a pointer
> into another process's address space.

I've investigated this in past to do the same thing you're trying (in my
case I was interested in a full user space implementation of OSS
emulation layer for ALSA).

The other huge drawback for ptrace is the impossibility to use mmap.

With older versions of Linux it was feasible to mmap /proc/PID/mem and
this was a very elegant way to do the job.

Unfortunately this feature has been dropped, but I don't know for which
reasons.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
