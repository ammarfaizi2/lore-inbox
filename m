Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSLJQ6L>; Tue, 10 Dec 2002 11:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSLJQ6L>; Tue, 10 Dec 2002 11:58:11 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:44244 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262373AbSLJQ6K>; Tue, 10 Dec 2002 11:58:10 -0500
Date: Tue, 10 Dec 2002 17:05:42 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
Message-ID: <20021210170542.GB577@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Antonino Daplas <adaplas@pol.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1039522886.1041.17.camel@localhost.localdomain> <20021210131143.GA26361@suse.de> <1039538881.2025.2.camel@localhost.localdomain> <20021210140301.GC26361@suse.de> <1039547210.1071.26.camel@localhost.localdomain> <20021210172320.A4586@suse.de> <1039539977.14251.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039539977.14251.40.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 05:06:17PM +0000, Alan Cox wrote:
 > Given how fragile the AGP code can be I would much rather we had the AGP
 > continue to initialize late. If the AGP init function is something like
 > 
 > 
 > int agp_required(void)
 > {
 > 	static int agp_inited = 0;
 > 
 > 	if(!agp_inited)
 > 	{
 > 		agp_inited = 1;
 > 		agp_do_real_init();
 > 	}
 > }
 > 
 > module_init(agp_required);
 > 
 > 
 > Then the i810 fb driver can do
 > 
 > 	agp_required();
 > 
 > and force the order change only if necessary.

That works for me. It's not ideal, but it's the cleanest
solution suggested so far. I'll hack a check into
agp_init() to do this, which should allow us to close bug #20 [*]

        Dave

[*] http://bugzilla.kernel.org/show_bug.cgi?id=20

