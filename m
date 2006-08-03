Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWHCXfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWHCXfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHCXfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:35:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:50906 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932556AbWHCXfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:35:06 -0400
X-Authenticated: #428038
Date: Fri, 4 Aug 2006 01:35:03 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Russell Leighton <russ@elegant-software.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Checksumming blocks? [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060803233503.GB25727@merlin.emma.line.org>
Mail-Followup-To: Russell Leighton <russ@elegant-software.com>,
	linux-kernel@vger.kernel.org
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF84F0.8080303@slaphack.com> <1154452770.15540.65.camel@localhost.localdomain> <44CF9217.6040609@slaphack.com> <20060803135811.GA7431@merlin.emma.line.org> <44D285DF.7060905@elegant-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D285DF.7060905@elegant-software.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I've stripped the Cc: list down to the bones.
No need to shout side topics from the rooftops.)

On Thu, 03 Aug 2006, Russell Leighton wrote:

> If the software (filesystem like ZFS or database like Berkeley DB)  
> finds a mismatch for a checksum on a block read, then what?

(Note that this assumes a Berkeley DB in transactional mode.) Complain,
demand recovery, set the panic flag (refusing further transactions
except close and open for recovery).

> Is there a recovery mechanism, or do you just be happy you know there is 
> a problem (and go to backup)?

Recoverability depends on log retention policy (set by the user or
administrator) and how recently the block was written. There is a
recovery mechanism.

For applications that don't need their own recovery methods (few do),
db_recover can do the job.

In typical cases of power loss or kernel panic during write, the broken
page will probably either be in the log so it can be restored (recover
towards commit), or, if the commit hadn't completed but pages had been
written due to cache conflicts, the database will be rolled back to the
state before the interrupted transaction, effectively aborting the
transaction.

The details are in the Berkeley DB documentation, which please see.

-- 
Matthias Andree
