Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWISSLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWISSLF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 14:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWISSLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 14:11:05 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:22190 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030285AbWISSLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 14:11:02 -0400
Date: Tue, 19 Sep 2006 14:11:01 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Martin Bligh <mbligh@google.com>
Cc: prasanna@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       "Frank Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919181101.GE26339@Krystal>
References: <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919175405.GC26339@Krystal> <4510308A.1070401@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4510308A.1070401@google.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 14:07:23 up 27 days, 15:16,  4 users,  load average: 0.26, 0.27, 0.23
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Bligh (mbligh@google.com) wrote:
> Mathieu Desnoyers wrote:
> >* Martin Bligh (mbligh@google.com) wrote:
> >
> >jump. I think it would be doable to overwrite a 5+ bytes instruction with 
> >a NOP
> >non-atomically in all cases, but as the instructions not in the prologue 
> >seems to
> >be smaller :
> >
> >prologue on x86
> >   0:   55                      push   %ebp
> >   1:   89 e5                   mov    %esp,%ebp
> >epilogue on x86
> >   3:   5d                      pop    %ebp
> >   4:   c3                      ret
> >
> >Then is can be a problem. Ideas are welcome.
> 
> Ugh, yes that's somewhat problematic. It does seem rather unlikely that
> there's a function call in the function prologue when we're busy 
> offloading stuff onto the stack, but still ...
> 
A function call is not the cause of the problem : an interrupt/trap is.

> For the cases where we're prepared to overwrite the call instruction in
> the caller, rather than insert an extra jump in the callee, can we not
> do that atomically by overwriting the address we're jumping to (the
> call is obviously there already)? Doesn't fix function pointers, etc,
> but might work well for the simple case at least.
> 
I don't think we have any guarantee that the function pointer in the call is
aligned, so I guess it would not be an atomic replacement.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
