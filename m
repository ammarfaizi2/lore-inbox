Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUGGSyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUGGSyl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUGGSyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:54:40 -0400
Received: from BACHE.ECE.CMU.EDU ([128.2.129.23]:384 "EHLO bache.ece.cmu.edu")
	by vger.kernel.org with ESMTP id S265315AbUGGSy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:54:26 -0400
Subject: Re: In-kernel Authentication Tokens (PAGs)
From: John Bucy <bucy@gloop.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: David Howells <dhowells@redhat.com>, Blair Strang <bls@asterisk.co.nz>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <D3C62886-C9EE-11D8-947A-000393ACC76E@mac.com>
References: <643CA25E-C091-11D8-8574-000393ACC76E@mac.com>
	 <984AC744-BFFB-11D8-8574-000393ACC76E@mac.com>
	 <FC6EBB12-BF27-11D8-95EB-000393ACC76E@mac.com>
	 <1087282990.13680.13.camel@lade.trondhjem.org>
	 <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>
	 <1087080664.4683.8.camel@lade.trondhjem.org>
	 <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com>
	 <1087084736.4683.17.camel@lade.trondhjem.org>
	 <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com>
	 <87smcxqqa2.fsf@asterisk.co.nz> <8666.1087292194@redhat.com>
	 <10430.1087397355@redhat.com> <30952.1087472906@redhat.com>
	 <5447.1087993789@redhat.com> <D3C62886-C9EE-11D8-947A-000393ACC76E@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1089226465.862.54.camel@catalepsy.pdl.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Jul 2004 14:54:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Speaking as a member of the AFS community, I'm thrilled to see this
coming along since PAGs are the major stumbling block for openafs in
2.6.  I won't speak for Coda and NFSv4 but hopefully, this can help them
out as well.

The policy that a number of AFS people want is that (1) processes with
different UIDs can share the same keyring and that (2) a number of
processes with the same UID can opt not to share the same keyring.  (1)
e.g. I have AFS creds (krb5 tickets) and want to run a setuid binary
with my creds.  (2) e.g. I want to have a bunch of xterms some with
administrative rights and some with normal rights.  Maybe I'm running
stuff out of cron or something under my UID that gets creds from a
ticket file, etc, and don't want it to interfere with my interactive use
of the machine.

>From my reading of the posts so far, it looks like (1) is no problem
since setuid() wouldn't touch the keyrings.  I'm less sure about (2). 
Does creating a new keyring (KEYCTL_NEW_RING) replace one of my existing
keyrings?  Which one?  To implement (2), do I need the ability to
explicitly zero-out some of my keyring associations?
 


john
