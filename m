Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUAAPHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 10:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264397AbUAAPHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 10:07:07 -0500
Received: from holomorphy.com ([199.26.172.102]:13769 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263571AbUAAPHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 10:07:05 -0500
Date: Thu, 1 Jan 2004 07:06:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Michel D?nzer <michel@daenzer.net>
Cc: Arjan van de Ven <arjanv@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
Message-ID: <20040101150653.GC3242@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Michel D?nzer <michel@daenzer.net>,
	Arjan van de Ven <arjanv@redhat.com>,
	Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel <dri-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com> <1072958618.1603.236.camel@thor.asgaard.local> <1072959055.5717.1.camel@laptop.fenrus.com> <1072959820.1600.252.camel@thor.asgaard.local> <20040101122851.GA13671@devserv.devel.redhat.com> <1072967278.1603.270.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072967278.1603.270.camel@thor.asgaard.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 03:27:59PM +0100, Michel D?nzer wrote:
> Does this look better? Maybe a macro (or a typedef?) for the type of the
> last argument would still be a good idea? Or is there yet a better way?

I'm going to regret suggesting this, but how about:
(a) a typedef for the arg itself
(b) a macro and/or inline for the type update

both simultaneously?

So we'd have centralized in one place:

#if /* kernel version > 2.6.0 */
typdef int *third_arg_t;
#define third_arg_update(type)	do { *(type) = VM_FAULT_MINOR; } while (0)
#else
typdef int third_arg_t;
#define third_arg_update(type)	do { } while (0)
#endif

... and the natural usage that follows.

-- wli
