Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318927AbSHEXRl>; Mon, 5 Aug 2002 19:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318930AbSHEXRl>; Mon, 5 Aug 2002 19:17:41 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:17670 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318927AbSHEXRk>; Mon, 5 Aug 2002 19:17:40 -0400
Date: Tue, 6 Aug 2002 00:21:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: john stultz <johnstul@us.ibm.com>
Cc: marcelo <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
       Leah Cunningham <leahc@us.ibm.com>, wilhelm.nuesser@sap.com,
       paramjit@us.ibm.com
Subject: Re: [PATCH] tsc-disable_B7
Message-ID: <20020806002112.A32243@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	john stultz <johnstul@us.ibm.com>,
	marcelo <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Leah Cunningham <leahc@us.ibm.com>, wilhelm.nuesser@sap.com,
	paramjit@us.ibm.com
References: <1028588288.1073.42.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028588288.1073.42.camel@cog>; from johnstul@us.ibm.com on Mon, Aug 05, 2002 at 03:58:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Mon Aug  5 15:41:40 2002
+++ b/Documentation/Configure.help	Mon Aug  5 15:41:40 2002
@@ -233,7 +233,21 @@
   network and embedded applications.  For more information see the
   Axis Communication site, <http://developer.axis.com/>.
 
-Multiquad support for NUMA systems
+Multi-node support for NUMA systems

What's the difference between CONFIG_X86_NUMA and CONFIG_MULTIQUAD?

If CONFIG_X86_NUMA is for numaq boxens please use CONFIG_X86_NUMAQ as
in pat's patch.


 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+	bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
+	if [ "$CONFIG_X86_NUMA" = "y" ]; then
+		bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
+	fi
 fi

config.in files have three-space indents.
 
+
+if [ "$CONFIG_X86_HAS_TSC" = "y" ]; then
+	if [ "$CONFIG_X86_NUMA" = "y" ]; then
+		define_bool CONFIG_X86_TSC n
+	else
+		define_bool CONFIG_X86_TSC y
+	fi
+fi
+
 
+			if(!bad_tsc){
+				use_tsc = 1;
+				x86_udelay_tsc = 1;
+				#ifndef do_gettimeoffset
+				do_gettimeoffset = do_fast_gettimeoffset;
+				#endif
+			}

you want to read Documentation/CodingStyle, don't you?

