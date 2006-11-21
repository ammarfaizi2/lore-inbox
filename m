Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030822AbWKUKOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030822AbWKUKOz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbWKUKOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:14:55 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:39125 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030816AbWKUKOy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:14:54 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/22] powerpc: convert idle_loop to use hard_irq_disable()
Date: Tue, 21 Nov 2006 11:14:45 +0100
User-Agent: KMail/1.9.5
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
References: <20061120174454.067872000@arndb.de> <20061120180520.418063000@arndb.de> <1164070425.8073.40.camel@localhost.localdomain>
In-Reply-To: <1164070425.8073.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611211114.46305.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 01:53, Benjamin Herrenschmidt wrote:
> +
> +       /*
> +        * We need to hard disable interrupts, but we also need to mark them
> +        * hard disabled in the PACA so that the local_irq_enable() done by
> +        * our caller upon return propertly hard enables.
> +        */
> +       hard_irq_disable();
> +       get_paca()->hard_enabled = 0;
> +

Yes, this looks good. Paul, please use this patch instead of mine.
Do we need to do the same thing for any of the other power_save functions?
IIRC, all new CPUs are supposed to use the same mechanism based on the
0x100 vector.

	Arnd <><
