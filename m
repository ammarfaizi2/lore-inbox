Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbTBDTpX>; Tue, 4 Feb 2003 14:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTBDTpW>; Tue, 4 Feb 2003 14:45:22 -0500
Received: from tartarus.telenet-ops.be ([195.130.132.46]:48813 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S267441AbTBDTpK> convert rfc822-to-8bit; Tue, 4 Feb 2003 14:45:10 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bart De Schuymer <bdschuym@pandora.be>
To: Rusty Russel <rusty@rustcorp.com.au>
Subject: module removal race possible in nf_sockopt?
Date: Tue, 4 Feb 2003 17:47:25 +0100
X-Mailer: KMail [version 1.4]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302041747.25334.bdschuym@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rusty,

Isn't there a module race possible with the netfilter function nf_sockopt 
(net/core/netfilter.c)? This function calls the sockopt function of a 
registered netfilter module, like iptables. F.e. the function do_ipt_set_ctl 
in ip_tables.c could be called.
What if the iptables module is being unloaded on one cpu, while another cpu 
just called do_ipt_set_ctl?
I think there needs to be a try_module_get and module_put in the nf_sockopt 
function to handle this. What do you think?

-- 
cheers,
Bart

