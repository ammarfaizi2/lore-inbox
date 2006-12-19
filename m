Return-Path: <linux-kernel-owner+w=401wt.eu-S932413AbWLSAFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWLSAFr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 19:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWLSAFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 19:05:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932413AbWLSAFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 19:05:46 -0500
Date: Mon, 18 Dec 2006 19:05:40 -0500
From: Dave Jones <davej@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>
Cc: Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/2] agpgart - Remove unnecessary flushes.
Message-ID: <20061219000540.GB20443@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>,
	Dave Airlie <airlied@linux.ie>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <4579ADE5.7050107@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4579ADE5.7050107@tungstengraphics.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 07:24:37PM +0100, Thomas Hellström wrote:
 > This patch is to speed up flipping of pages in and out of the AGP 
 > aperture as needed by the new drm memory manager.
 > 
 > A number of global cache flushes are removed as well as some PCI posting 
 > flushes.
 > The following guidelines have been used:
 > 
 > 1) Memory that is only mapped uncached and that has been subject to a 
 > global cache flush after the mapping was changed to uncached does not 
 > need any more cache flushes. Neither before binding to the aperture nor 
 > after unbinding.
 > 
 > 2) Only do one PCI posting flush after a sequence of writes modifying 
 > page entries in the GATT.
 > 
 > Patch against davej's agpgart.git

I looked at applying this one to agpgart.git, as it's less controversial
than the other patch. However,..

- MIME : just say no. I had to hand fix up a few things before git would
  even see that I was feeding it a diff.
- No Signed-off-by: line.
- The diff adds trailing whitespace. This makes git sad also.
  (This problem also affects the other diff, which is possibly why...)
- Finally..
   error: patch failed: drivers/char/agp/generic.c:1076
   error: drivers/char/agp/generic.c: patch does not apply
   error: patch failed: drivers/char/agp/intel-agp.c:256
   error: drivers/char/agp/intel-agp.c: patch does not apply

  Perhaps this diff should have have been [1/2] instead.

Can you fix those up, and resend this one?

The other diff I want to chew over some more before applying, especially
after Arjan's comments.

		Dave

-- 
http://www.codemonkey.org.uk
