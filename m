Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVALAyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVALAyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbVALAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:50:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262978AbVALArM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:47:12 -0500
Date: Tue, 11 Jan 2005 19:46:19 -0500
From: Dave Jones <davej@redhat.com>
To: domen@coderock.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hannal@us.ibm.com,
       janitor@sternwelten.at
Subject: Re: [patch 03/11] arch/i386/pci/i386.c: Use new for_each_pci_dev macro
Message-ID: <20050112004618.GT29712@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, domen@coderock.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org, hannal@us.ibm.com,
	janitor@sternwelten.at
References: <20050111233458.9B8E01F228@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111233458.9B8E01F228@trashy.coderock.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 12:34:58AM +0100, domen@coderock.org wrote:

 > As requested by Christoph Hellwig I've created a new macro called
 > for_each_pci_dev. It is a wrapper for this common use of pci_get/find_device:
 > 
 > (while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL))
 > 
 > This macro will return the pci_dev *for all pci devices.  Here is the first patch I 
 > used to test this macro with. Compiled and booted on my T23. There will be
 > 53 more patches using this new macro.

Which looks just like the pci_for_each_dev we used to have.
That function got removed due some shortcoming or other that I never
fully understood, but ISTR it had something to do with locking.
(why it couldnt be hidden inside for_each_pci_dev is a mystery to me)

We've had lots of code in the kernel go from this..

pci_for_each_dev(loop_dev) {

to the disgustingly unreadable..

while ((loop_dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, loop_dev)) != NULL) {

and now its going to ..

for_each_pci_dev(loop_dev) {

So,.. what has all this churn bought us, and where does it end ?
With four words in the function name, we've enough possibilities
for quite a few more iterations yet.

		Dave

