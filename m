Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263159AbTCSUpy>; Wed, 19 Mar 2003 15:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263164AbTCSUpx>; Wed, 19 Mar 2003 15:45:53 -0500
Received: from motgate4.mot.com ([144.189.100.102]:9186 "EHLO motgate4.mot.com")
	by vger.kernel.org with ESMTP id <S263159AbTCSUpw>;
	Wed, 19 Mar 2003 15:45:52 -0500
Message-ID: <6D4DC8B4AD16D6118E8200D0B76FE26203DB81BB@ont06exm01.comm.mot.com>
From: Barker Michael-r43496 <Michael.D.Barker@motorola.com>
To: linux-kernel@vger.kernel.org
Subject: questions about ipconfig.c, auto-configuration
Date: Wed, 19 Mar 2003 15:55:05 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am a newbie and this is my first post to this list.

In net/ipv4/ipconfig.c (I'm looking at linuxppc versions in 2.4 and 2.5 trees)
There is a comment describing an if statement.  To me it seems that either the comment is wrong or the if statement is wrong.  Which is it, or how am I misinterpreting?
The phrase "we have multiple network interfaces and no default was set" should correspond to something like (ic_first_dev->next && !ic_default), but there is no ic_default.

	/*
	 * If the config information is insufficient (e.g., our IP address or
	 * IP address of the boot server is missing or we have multiple network
	 * interfaces and no default was set), use BOOTP or RARP to get the
	 * missing values.
	 */
	if (ic_myaddr == INADDR_NONE ||
#ifdef CONFIG_ROOT_NFS
	    (MAJOR(ROOT_DEV) == UNNAMED_MAJOR
	     && root_server_addr == INADDR_NONE
	     && ic_servaddr == INADDR_NONE) ||
#endif
	    ic_first_dev->next) {


How this affects me: I get to this point with three ethernet devices eth0,eth1,eth2 and would like to use the valid parameters in ic_myaddr et al for eth0 and leave the other two to be manually configured after boot time.  But because there are multiple interfaces, ic_first_dev->next is not NULL so ic_dynamic gets called and DHCP is attempted for eth0 instead of using ic_myaddr et al.

So, what am I missing?  Where am I supposed to "set a default" when I have multiple interfaces?

Thanks for your attention

-- 
Michael D. Barker
Sr. Designer, Software, Motorola SPS Canada
This email along with any attachments is classified as General Business Information
