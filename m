Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264234AbVBDXTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264234AbVBDXTf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbVBDW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:59:06 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:55029 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265567AbVBDWWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:22:51 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.62896.559319.678176@tut.ibm.com>
Date: Fri, 4 Feb 2005 16:22:40 -0600
To: Andi Kleen <ak@muc.de>
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 3
In-Reply-To: <20050204221230.GA97506@muc.de>
References: <16899.55393.651042.627079@tut.ibm.com>
	<20050204221230.GA97506@muc.de>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > 
 > > +
 > > +	local_irq_save(flags);
 > > +	if (unlikely(buf->offset + length > chan->subbuf_size))
 > > +		length = relay_switch_subbuf(buf, length);
 > > +	memcpy(buf->data + buf->offset, data, length);
 > > +	buf->offset += length;
 > > +	local_irq_restore(flags);
 > > + 
 > > +	return length;
 > 
 > Is there any useful user case for returning length here? 
 > (e.g. are users likely to handle errors? I doubt it somehow) 
 > 
 > If not I would eliminate it.
 > 

The main reason would be that length would be 0 only if the buffers
were full, so the caller can suspend writing if it sees that, until
e.g. a daemon catches up.

Thanks for your other comments - I'll make those changes in the next
version.

Tom

