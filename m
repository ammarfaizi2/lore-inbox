Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTK1Q7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTK1Q7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:59:52 -0500
Received: from uns-y1.unisinos.br ([200.188.162.1]:13304 "EHLO
	sav03.unisinos.br") by vger.kernel.org with ESMTP id S262725AbTK1Q7u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:59:50 -0500
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: Felipe W Damasio <felipewd@elipse.com.br>,
       Lista da disciplina de Sistemas Operacionais III 
	<sisopiii-l@cscience.org>
Subject: Re: [SisopIII-l] Re: [PATCH] fix #endif misplacement
Date: Fri, 28 Nov 2003 14:59:08 -0200
User-Agent: KMail/1.5.3
Cc: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br> <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de> <3FC77A59.2090705@elipse.com.br>
In-Reply-To: <3FC77A59.2090705@elipse.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311281459.08071.lucasvr@gobolinux.org>
X-unisinos-MailScanner-Information: Please contact the ISP for more information
X-unisinos-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Actually, the original code seems to be ok:

#ifndef CONFIG_NUMA
        if (!use_tsc)
#endif
        return (unsigned long long)jiffies * (1000000000 / HZ);

That is: on x86 we'll get into "#ifndef CONFIG_NUMA", and "if (!use_tsc)" will 
be called, which should be the expected behaviour.

Maybe in your case the use_tsc flag was being set to 0 (bug in detection code 
/ unsupported feature by the processor?), leading your code to ignore the TSC 
and return the current time based on the current jiffies instead.

Lucas


On Friday 28 November 2003 14:39, Felipe W Damasio wrote:
> 	Hi Tim,
>
> Tim Schmielau wrote:
> > No, this is exactly what is intended: don't use the TSC on NUMA, use
> > jiffies instead.
>
> 	The patch didn't hurt this.
>
> > Look at the comment just above those lines.
>
> 	The patch doesn't uses jiffies indiscriminately: Only if we're on a
> NUMA system with !use_tsc.
>
> 	Otherwise (on x86 SMP, for example) we use rdtsc...which seems The
> Right Thing(tm). Hece move the #endif a bit down.
>
> 	Cheers
>
> Felipe
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

