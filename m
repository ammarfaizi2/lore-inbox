Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265216AbSIQXQ0>; Tue, 17 Sep 2002 19:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265217AbSIQXQ0>; Tue, 17 Sep 2002 19:16:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33156 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265216AbSIQXQ0>;
	Tue, 17 Sep 2002 19:16:26 -0400
Date: Tue, 17 Sep 2002 16:12:15 -0700 (PDT)
Message-Id: <20020917.161215.03597459.davem@redhat.com>
To: jamesclv@us.ibm.com
Cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209171555.52872.jamesclv@us.ibm.com>
References: <20020918004442.A32234@wotan.suse.de>
	<20020917.153828.24171342.davem@redhat.com>
	<200209171555.52872.jamesclv@us.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Cleverdon <jamesclv@us.ibm.com>
   Date: Tue, 17 Sep 2002 15:55:52 -0700
   
   The initial sync was easy, even with variable latencies on cache lines.  A 
   much simplified NTP-ish algorithm works fine.  The painful thing was bus 
   clock drift and programs that foolishly relied on the TSC being the same 
   between CPUs and between nodes.

This is why the gettimeofday implementation should use the system tick
thing and also any profiling support in the C library should avoid
TSC as well.

For small stretches of code TSC can be used for very precise profiling
but otherwise it is pretty useless by in large.
