Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264796AbUEKP6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbUEKP6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUEKP6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:58:44 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:63143 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264796AbUEKP6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:58:42 -0400
Date: Tue, 11 May 2004 17:58:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steve French <smfltc@us.ibm.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040511155827.GA11204@wohnheim.fh-wedel.de>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040508224835.GE29255@atrey.karlin.mff.cuni.cz> <20040510155359.GB16182@wohnheim.fh-wedel.de> <20040510192601.GA11362@delft.aura.cs.cmu.edu> <20040511100232.GA31673@wohnheim.fh-wedel.de> <1084290049.5135.11.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1084290049.5135.11.camel@stevef95.austin.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004 10:40:49 -0500, Steve French wrote:
> 
> It would not be helpful to take a userspace request to perform a file
> (or directory) copy operation and break it into open/sendfile/close by
> passing file handles to the network filesystem and have this work for
> SMB/CIFS - there is no equivalent network protocol operation.  It also
> makes the operation much, much harder to make atomic (since two systems
> are involved) and makes error handling and recovery for network
> filesystems much harder since inconsistent client and server state have
> to be considered if the copy operation is broken into pieces on the
> clien (it is also slower - a single copy operation on the network is the
> absolute optimal case - minimizes the expensive network latency - the
> roundtrip delay - open/sendfile/close sends at a minimum three times as
> many but likely four with an extra lookup or two)
> 
> Currently copy file (or copy directory for that matter) as both speced
> (and is implemented in various servers) in the SMB/CIFS network
> filesystem protocol takes in effect four parameters (there is no handle
> based file copy):
> 
> a source pathname,  and source export (actually SMB tree identifier for
> a share, but in effect the same thing) 
> a target pathname, and target export (actually SMB tree identifier for a
> share, but in effect the same thing) 
> And the shares (exports) referenced have to be on the same server

Or in short, copyfile makes sense for smbfs/cifs.  The question
whether my hack can be cleaned up enough to get past Al Viro is still
open, though. :)

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown
