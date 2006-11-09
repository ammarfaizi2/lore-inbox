Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966035AbWKIOmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966035AbWKIOmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966038AbWKIOmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:42:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:44486 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966035AbWKIOmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:42:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
Date: Thu, 9 Nov 2006 15:42:30 +0100
User-Agent: KMail/1.9.5
Cc: kvm-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091429.42040.arnd@arndb.de> <45532EE3.4000104@qumranet.com>
In-Reply-To: <45532EE3.4000104@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091542.31101.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 November 2006 14:36, Avi Kivity wrote:
> 
> >
> > I'm not an expert on inline assembly, but don't you need an extra
> > '"m" (phys_addr)' to make sure that gcc actually puts the variable
> > on the stack instead of passing a NULL pointer as '"a"(&phys_addr)'?
> 
> Taking a variable's address should force its contents into memory (like 
> calling an uninlined function with &var).

No it doesn't. You're not telling gcc that the inline assembly cares
about the contents of the variable, so it could be a reference to
a stack slot while the contents are still in a register. Or gcc
might move the assignment of phys_addr to after the inline assembly.

	Arnd <><
