Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVCBR6C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVCBR6C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVCBR6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:58:02 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:63951 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262382AbVCBR5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:57:18 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
Date: Wed, 2 Mar 2005 09:56:57 -0800
User-Agent: KMail/1.7.2
Cc: Jay Lan <jlan@sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>
References: <421EA8FF.1050906@sgi.com> <4224AF3D.3010803@sgi.com> <1109749735.8422.104.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1109749735.8422.104.camel@frecb000711.frec.bull.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503020956.57637.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 1, 2005 11:48 pm, Guillaume Thouvenin wrote:
> Is it possible to merge BSD and CSA? I mean with CSA, there is a part
> that does per-process accounting. For exemple in the
> linux-2.6.9.acct_mm.patch the two functions update_mem_hiwater() and
> csa_update_integrals() update fields in the current (and parent)
> process. So maybe you can improve the BSD per-process accounting or
> maybe CSA can replace the BSD per-process accounting?

The BSD accounting tools will expect the data to be written in a certain 
format, so we can't change that.  We could, however, unify the data 
collection under CONFIG_ACCOUNTING or something, that collects all the data 
available (which would be the sum of the data collected by the BSD and CSA 
calls) and then throw away data when writing to the BSD log so its format 
remains the same.

That would simplify data collection since there would just be one set of 
calls, and data reporting could be driven by userspace (whether it's in 
old-style sys_acct format, or new-style data that CSA/ELSA defines).

Jesse
