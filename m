Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272308AbRHXTm2>; Fri, 24 Aug 2001 15:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272310AbRHXTmS>; Fri, 24 Aug 2001 15:42:18 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:14751 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S272306AbRHXTmM>;
	Fri, 24 Aug 2001 15:42:12 -0400
Date: Fri, 24 Aug 2001 21:42:21 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010824214221.A12903@fuji.laendle>
Mail-Followup-To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010823233557.A12873@cerebro.laendle> <200108240739.f7O7dWj01330@mailc.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200108240739.f7O7dWj01330@mailc.telia.com>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 09:35:08AM +0200, Roger Larsson <roger.larsson@skelleftea.mail.telia.com> wrote:
> And I found out that read ahead was too short for modern disks.

That could well be, the problem in my case is that, with up to 1000
clients, I fear that there might not be enough memory for effective
read-ahead (and I think read-ahead would be counter-productive even).

> line is the  
> -#define MAX_READAHEAD  31
> +#define MAX_READAHEAD  511

I plan to try this, however, read-ahead should IMHO be zero anyway, since
there simply is ot enough memory, and the kernel should not do much
read-ahead when many other requests are outstanding.

The real problem., however, is that read performance sinks so much when many
readers run in parallel.

What I need is many parallel reads because this helps the elevator scan the
disk once and not jump around widely)

(I have 512MB memory around 64k socket send buffer and use an additional
96k buffer currently for reading from disk, so effectively i do my own
read-ahead anyway. IU just need to optimize the head movements).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
