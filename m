Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTJAX1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTJAX1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:27:10 -0400
Received: from johanna5.ux.his.no ([152.94.1.25]:8608 "EHLO johanna5.ux.his.no")
	by vger.kernel.org with ESMTP id S262705AbTJAX1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:27:07 -0400
Date: Thu, 2 Oct 2003 01:26:50 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: Matt Mackall <mpm@selenic.com>
Cc: Steve French <sfrench@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031001232650.GB18028@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
References: <20030902203041.GA25675@johanna5.ux.his.no> <20031001133039.GA32610@badne3.ux.his.no> <20031001195522.GK1897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001195522.GK1897@waste.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/03 14:55, Matt Mackall wrote:
> On Wed, Oct 01, 2003 at 03:30:39PM +0200, Erlend Aasland wrote:
> >  static int cifs_calculate_signature(const struct smb_hdr * cifs_pdu, const char * key, char * signature)
> [...]
> Eek. How often does this get called?
It is (normally) called twice in SendReceive(). SendReceive() is called
very often in cifs. After a quick look at cifs, it seems that most of
these calls are protected with a per connection-lock (correct me if I'm
wrong). But since two connections can call SendReceive() at the same
time, we have to protect the tfm with locks. Correct?

Would a better solution be to allocate one tfm per connection, thus
no need to protect the tfm with a dedicated lock, right?

[Or is converting cifs to the cryptoapi is waste of time? (I hope not :-) ]

Regards
	Erlend Aasland
