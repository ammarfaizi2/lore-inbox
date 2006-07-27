Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWG0Ou4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWG0Ou4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWG0Ou4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:50:56 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:33037 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751223AbWG0Ouz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:50:55 -0400
Message-ID: <44C8D25B.6040402@shadowen.org>
Date: Thu, 27 Jul 2006 15:48:59 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2-mm1
References: <20060727015639.9c89db57.akpm@osdl.org> <44C8C804.7050805@shadowen.org>
In-Reply-To: <44C8C804.7050805@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Seems that this one is eating /dev/null's during 'make' phase of a 
> build.  Am trying to track down whats changed.

Ok, this seems to be related to the changes in:

	vdso-hash-style-fix.patch

Backing this out reverses the new behaviour.

It looks like the check to see if the options are valid, use -o 
/dev/null -xc /dev/null and that is causing the compiler to remove 
/dev/null.

The machines affected do not seem to have such old compilers:	
	
	gcc version 3.3.4 (Debian 1:3.3.4-3)

Yeah, yeah I know I should not be running my builds as root, but then we 
should not be eating it either.

-apw
