Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbTIDEh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTIDEh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:37:28 -0400
Received: from pat.uio.no ([129.240.130.16]:5847 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264591AbTIDEh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:37:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16214.49538.216630.336724@charged.uio.no>
Date: Thu, 4 Sep 2003 00:37:22 -0400
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] attempt to use V1 mount protocol on V3 server
In-Reply-To: <Pine.LNX.4.44.0309040433540.8732-100000@neptune.local>
References: <16214.41175.580602.671154@charged.uio.no>
	<Pine.LNX.4.44.0309040433540.8732-100000@neptune.local>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pascal Schmidt <der.eremit@email.de> writes:

     > Out of interest, how does this work? Not obvious to me since an
     > NFSv3 filehandle is too big for an NFSv2 server.

Most are not. An NFSv3 filehandle has a variable size (as opposed to
NFSv2 which are fixed size), and so most NFS servers use the same
filehandle for NFSv2 and NFSv3.

Note: The reason for this mess is that the early Linux-2.2.x knfsd
servers were NFSv2 only. Unfortunately, the associated kmountd daemon
would advertise that it did NFSv3 too, in which case it just returned
the same NFSv2 filehandles. By retrying the GETATTR call in the NFSv3
client, and automatically switching to NFSv2 we were able to catch
these buggy setups.


Note: The fact that we are now stuck with a schizophrenic NFSv3 client
is one of the many reasons why I am now *very* wary of trying to work
around server bugs by making fixes to the client code.

Cheers,
  Trond
