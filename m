Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVBNRJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVBNRJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 12:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVBNRJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 12:09:46 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:53920
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261489AbVBNRJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 12:09:42 -0500
Date: Mon, 14 Feb 2005 09:07:26 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       michal@logix.cz, adam@yggdrasil.com
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050214090726.2d099d96.davem@davemloft.net>
In-Reply-To: <1108400799.23133.34.camel@ghanima>
References: <Xine.LNX.4.44.0502101247390.9159-100000@thoron.boston.redhat.com>
	<1108387234.8086.37.camel@ghanima>
	<20050214075655.6dec60cb.davem@davemloft.net>
	<1108400799.23133.34.camel@ghanima>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2005 18:06:39 +0100
Fruhwirth Clemens <clemens@endorphin.org> wrote:

> There is nothing wrong with having special methods, that lack generality
> but are superior in performance. There is something wrong, when there
> are no other. And there are no other for holding three kmappings or more
> concurrently.

You want more resources in a context where no such thing exists,
in interrupt processing context.  There the stack is limited, allocatable
memory is limited, etc. etc. etc.  And all of this is because you cannot
sleep in interrupt context.

Resources are fixed in this environment exactly becuase one cannot
sleep or wait on events.  It's supposed to be fast processing, deferring
more involved work to process context.
