Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSFDDTK>; Mon, 3 Jun 2002 23:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSFDDTJ>; Mon, 3 Jun 2002 23:19:09 -0400
Received: from jalon.able.es ([212.97.163.2]:27617 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316158AbSFDDTH>;
	Mon, 3 Jun 2002 23:19:07 -0400
Date: Tue, 4 Jun 2002 05:18:40 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Algorithm for CPU_X86
Message-ID: <20020604031840.GA4289@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Following with the cpu selection changes, setting the flags controlled
by the various CPU_X86_xxxx can be a real mess.

But, I have ralized that those CPU_X86 flags can be logically split in
two groups: features (TSC,MMX,3DNOW) and bugfixes (PPRO_FENCE) (or perhaps
more, it is just a first thought...).

So the algorithm can be easy (i think..)
- Enable all feature flags (say, MMX and 3DNOW)
- Disable all bugfix flags (FENCE)
- For each CPU
     if it does not have the feature, kill it
     (if VENDOR_INTEL set 3DNOW=n)
     if this-cpu-kernel could run on buggy-cpu, enable fix
     (if GENERIC_586 set FENCE=y)

Right ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP lun jun 3 19:59:12 CEST 2002 i686
