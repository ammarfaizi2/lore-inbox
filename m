Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUAJOac (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 09:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUAJOac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 09:30:32 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:3968
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265171AbUAJOab convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 09:30:31 -0500
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange>
References: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073745028.1146.13.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 09:30:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 10/01/2004 klokka 06:10, skreiv Guennadi Liakhovetski:
> Yes. The reason for the problem seems to be the increased default size of
> the transfer unit of NFS from 2.4 to 2.6. 8K under 2.4 was still ok, 16K
> is too much - only the first 5 fragments pass fine, then data starts to
> get lost. If it is a hardware limitation (not all platforms can manage
> 16K), it should be probably set back to 8K. If the reason is that some
> buffer size was not increased correspondingly, then this should be done.

No! People who have problems with the support for large rsize/wsize
under UDP due to lost fragments can

  a) Reduce r/wsize themselves using mount
  b) Use TCP instead

The correct solution to this problem is (b). I.e. we convert mount to
use TCP as the default if it is available. That is consistent with what
all other modern implementations do.

Changing a hard maximum on the server in order to fit the lowest common
denominator client is simply wrong.

Cheers,
  Trond
