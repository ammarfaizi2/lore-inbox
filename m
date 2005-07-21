Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVGUWsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVGUWsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVGUWsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:48:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:15031 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261923AbVGUWqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:46:44 -0400
Subject: Re: CIFS slowness & crashes
From: Steve French <smfltc@us.ibm.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Lasse =?ISO-8859-1?Q?K=E4rkk=E4inen?= / Tronic 
	<tronic+lzID=lx43caky45@trn.iki.fi>,
       linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>
In-Reply-To: <9a87484905072115041cc576a4@mail.gmail.com>
References: <42E01163.3090302@trn.iki.fi>
	 <9a87484905072115041cc576a4@mail.gmail.com>
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1121985800.26832.41.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Jul 2005 17:43:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 2. Occassionally the transmission speeds go extremely low for no
> > apparent reason. While writing this, I am getting 0.39 Mo/s over a
> > gigabit network.

It would help to know whether you are doing mostly writing to or reading
from the server.

Forgot to mention that another thing that may help (besides the large
number of improvements that already went into 2.6.12 already to
drastically reduce the expensive large buffer usage, and the even newer
experimental CIFS write code) are two configuration changes - either
dropping the buffer size to relieve pressure on the slab (e.g. to just
under 8K - perhaps 7800 bytes) or increasing the number of large buffers
in the pool (they are insmod parms of cifs.ko - you can do modinfo on
cifs.ko to see them) so fewer allocations are done.  This would only be
needed if multiple processes were accessing the mount at one time.

