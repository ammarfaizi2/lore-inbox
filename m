Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWCFRlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWCFRlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCFRlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:41:49 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:28390 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751083AbWCFRls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:41:48 -0500
X-ORBL: [69.149.117.231]
Date: Mon, 6 Mar 2006 11:37:00 -0600
From: Michael Halcrow <lkml@halcrow.us>
To: V Bhanu Chandra <vbhanu.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Encrypting file system
Message-ID: <20060306173659.GA12970@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <Pine.LNX.4.64.0603061600540.16555@vattikonda.junta.iitk.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603061600540.16555@vattikonda.junta.iitk.ac.in>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 04:01:33PM +0530, V Bhanu Chandra wrote:
> I am thinking of designing and implementing a new native encrypting
> file system for the linux kernel as a part of a student / research
> project. Unlike dm-crypt/loop-AES/cryptoloop, I plan to target
> slightly more ambitious user specifications such as: per-file random
> secret encryption keys which are in-turn encrypted using the public
> keys of all users having access to that filesystem object (a copy
> each), and these "tokens" stored along with the file as meta-data
> (in an extended attribute, for example).

You have just described exactly what I presented at OLS 2004 and
2005. The paper is available in the symposium proceedings. Another
post on this thread pointed to the eCryptfs web site:

http://ecryptfs.sourceforge.net/

A version (0.1) with mount-wide passphrase support (with a random
session key per file) has been fully implemented and is available for
immediate use. If you are running kernel version 2.6.15, you can build
eCryptfs as a stand-alone module. There is a preliminary design
document under development that is available from the web site too. It
covers passphrase-only functionality for version 0.1, and I am in the
process of working on a design document for version 0.2, which will
include per-file public key support. In version 0.3, I plan to
implement more advanced key management and policy support.

> It would be helpful if someone has implemented (or is working on) a
> patch for the kernel that implements RSA in the CryptoAPI, else I
> might have to resort to have a user-space service for key management
> tasks.

For eCryptfs, I have decided that the public key operations be best
routed to userspace code due to their high computational overhead and
the need for additional operations that are necessary to make public
key meaningful from a security perspective, such as certificate
processing, CRL's, and so forth.

Thanks,
Mike Halcrow
eCryptfs Lead Developer
