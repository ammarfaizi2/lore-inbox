Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263532AbTJQVAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 17:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTJQVAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 17:00:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21212 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263532AbTJQVAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 17:00:02 -0400
Subject: Letext symbols in System.map
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1066424399.2589.171.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2003 13:59:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing intermittent Letext symbols showing up in System.maps
for a while.  They're annoying because they seem to plant themselves at
the same address as spinlocks and readprofile picks them over the
spinlock symbol.  

c02c40d9 t .text.lock.af_packet
c02c40d9 t Letext

For me, they only show up when CONFIG_DEBUG_INFO is turned on, but
Martin Bligh claims he's seen them other times as well.  

After some googling, it appears that Letext is supposed to be a label
for a string constant.  Since the spinlocks are defined using assembly
inside string constants, perhaps the label for that asm string is
hanging around too long.  

Is ther anything to keep us from simply grepping them away when
System.map is created?  

$(NM) $@ | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)\|\(Letext\)' | sort > System.map

-- 
Dave Hansen
haveblue@us.ibm.com

