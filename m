Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWBYVQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWBYVQN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 16:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWBYVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 16:16:13 -0500
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:49818 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750703AbWBYVQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 16:16:12 -0500
Date: Sat, 25 Feb 2006 16:11:34 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Bogus objdump output from kernel object files?
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Message-ID: <200602251614_MC3-1-B949-F65F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060225190324.GA9326@mars.ravnborg.org>

On Sat, 25 Feb 2006 at 20:03:24 +0100, Sam Ravnborg wrote:
> Let me know if anyone thinks something is bad with the kbuild
> make dir/foo.lst functionality and I will ahve a look.

Try it with Arjan's new "reorder functions" patch and you should
see some real breakage.  makelst assumes the entire .o file
gets placed in-order into vmlinux and a single --adjust-vma will
work for the entire file when it really needs to be done for each
section.  It was probably already broken because of .init.text
vs. .text sections but I never did check that.  And the "grep .text"
in line 1 is broken too; it needs to be "grep -F".

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

