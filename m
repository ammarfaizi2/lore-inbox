Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbUCAXgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 18:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbUCAXgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 18:36:09 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:63883 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S261486AbUCAXgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 18:36:03 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.25 intermittent (parallel) build failure
Date: Mon, 1 Mar 2004 23:36:00 +0000
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403012336.00411.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The failure seems occur when doing

	mv script.h sim710_d.h

in drivers/scsi. It's not actually a failure, but mv asking if it should 
overwrite a mode 444 file. On the occasions that it suceeds, the file seems 
to have been given 644 permissions.

I'm not entirely sure what is going on here, or why it is an intermittent 
failure. But perhaps the mv's should have a -f to prevent the question?

Perhaps mv is at fault. The documentation says

  "If a destination file exists but is normally unwritable, standard
input is a terminal, and the `-f' or `--force' option is not given,
`mv' prompts the user for whether to replace the file.  (You might own
the file, or have write permission on its directory.)  If the response
does not begin with `y' or `Y', the file is skipped."

I'm not sure why mv would think stdin is a terminal, since it's called by 
make.

Anyhow, Perhaps someone cleverer than I can work it out. Or tell me why I'm 
being stupid :)

Andrew Walrond
