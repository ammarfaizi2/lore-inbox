Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVFQTe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVFQTe2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 15:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVFQTe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 15:34:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15275 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262073AbVFQTeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 15:34:05 -0400
Date: Fri, 17 Jun 2005 20:35:17 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: mike.miller@hp.com
Cc: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] cciss 2.6: pci domain info
Message-ID: <20050617193517.GN11655@parcelfarce.linux.theplanet.co.uk>
References: <20050617183124.GA9913@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050617183124.GA9913@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 01:31:24PM -0500, mike.miller@hp.com wrote:
> This patch adds pci domain info to our CCISS_GETPCIINFO ioctl. This
> is to support the next generation of Itanium platforms. We had a couple
> of spare bytes in the structure. Impact to existing apps should be
> minimal. Please consider this patch for inclusion.

>  typedef struct _cciss_pci_info_struct
>  {
> +	unsigned int	domain;
>  	unsigned char 	bus;
>  	unsigned char 	dev_fn;
>  	__u32 		board_id;

Um, what?  There's no way this doesn't break the ABI.  You do have spare
bytes in the struct, but to use them, you have to add an 'unsigned short'
between dev_fn and board_id:

typedef struct _cciss_pci_info_struct
{
	unsigned char   bus;
	unsigned char   dev_fn;
+	unsigned int    domain;
	__u32           board_id;
}

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
