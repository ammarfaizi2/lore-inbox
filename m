Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTDOM2S (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTDOM2S 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:28:18 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:54913
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S261328AbTDOM2P 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:28:15 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Writing modules for 2.5
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel>
	<p73adesxane.fsf@oldwotan.suse.de> <yw1xllyc7yoz.fsf@zaphod.guide>
	<1050406513.27745.32.camel@dhcp22.swansea.linux.org.uk>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Apr 2003 14:39:14 +0200
In-Reply-To: <1050406513.27745.32.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <yw1xbrz87x59.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Next question:  what is the correct replacement for MOD_INC_USE_COUNT?
> 
> If you know the use count is already one there isnt one, jut use
> MOD_INC_USE_COUNT and flame Rusty
> 
> If you can't prove the use count is already one for your own module
> you have a problem (and did in 2.4 in truth). The layers try and 
> lock the layer below. So char drivers are locked by core code,
> block drivers likewise, tty drivers and so on...
> 
> Most driver layers now have an owner: field in the file ops or other
> structure they register
> 
> 	owner: THIS_MODULE,
> 
> (THIS_MODULE comes out currently in a non modular buils too)

My situation is like this: I am converting a char device driver to
work with linux 2.5.  In the open and close functions there are
MOD_INC/DEC_USECOUNT calls.  The question is what they should be
replaced with.  Will it be handled correctly without them?

-- 
Måns Rullgård
mru@users.sf.net
