Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVCRRSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVCRRSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVCRRSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:18:39 -0500
Received: from fmr20.intel.com ([134.134.136.19]:1503 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261955AbVCRRSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:18:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PCI Error Recovery API Proposal. (WAS::  [PATCH/RFC]PCIErrorRecovery)
Date: Fri, 18 Mar 2005 09:17:49 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024081326C3@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Error Recovery API Proposal. (WAS::  [PATCH/RFC]PCIErrorRecovery)
Thread-Index: AcUrZGX4MDIOYvgdS4Su3dDH7uNLqAAeCfHg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "Linas Vepstas" <linas@austin.ibm.com>,
       "Hidetoshi Seto" <seto.hidetoshi@jp.fujitsu.com>,
       "Greg KH" <greg@kroah.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <ak@muc.de>, "Paul Mackerras" <paulus@samba.org>,
       "linuxppc64-dev" <linuxppc64-dev@ozlabs.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 18 Mar 2005 17:17:49.0409 (UTC) FILETIME=[68FD4510:01C52BDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 17, 2005 6:44 PM Benjamin Herrenschmidt wrote:
>I have difficulties following all of your previous explanations, I must
>admit. My point here is I'd like you to find out if the API can fit on
>the driver side, and if not, what would need to be changed.

In summary, we agreed that the API you propose should be: 

int (*error_handler)(struct pci_dev *dev, union error_src *);

I believe this API works for most of PCI Express needs.  The only
addition PCI Express needs is a mechanism for the AER code to request a
port bus driver to perform a downstream link reset when an error occurs
on that downstream link. For example, you can add the
PCIERR_ERROR_PORT_RESET message with the return is either
PCIERR_RESULT_RECOVERED or PCIERR_RESULT_DISCONNECT to fit PCI Express
needs.

Thanks,
Long
