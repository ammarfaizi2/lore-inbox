Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290075AbSAQRSF>; Thu, 17 Jan 2002 12:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290078AbSAQRRy>; Thu, 17 Jan 2002 12:17:54 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:51716 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S290075AbSAQRRe>;
	Thu, 17 Jan 2002 12:17:34 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Christoph Pittracher <pitt@gmx.at>
Date: Thu, 17 Jan 2002 18:16:47 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: ncpfs input/output error
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <F2BDF7440AF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jan 02 at 17:48, Christoph Pittracher wrote:
> 
> read(3, "\337\375\337\341\273\257\344\n\264\0302%\231\337\233\261"..., 
> 512)
> = 512
> write(4, "\337\375\337\341\273\257\344\n\264\0302%\231\337\233\261"..., 
> 512)
> = -1 EIO (Input/output error)
> [...]
> 
> I don't know why this write fails...
> Any hints?

You should see some complaints in kernel log, or, maybe, on server's 
console. In kernel log you should see some 'NCP server not responding' or
'ncp_rpc_call: recv error = NN'. Or maybe you are getting 'An NCP request
with an invalid security signature was received from user <you> at
<your address>. Possible intruder or network corruption.'

You also must not send SIGKILL to processes which are in the middle of
NCP transaction. Because of ncpfs does not use its own thread (or bh)
to implement NCP ping-pong protocol, connection becomes invalid after
such action, as ping-pong was not successfully completed.

Are you sure that you do not have directory restriction
on your directory, and that you are not running some ipxripd which
could remove route to server from your routing tables?
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
P.S.: It is possible to create 2GB file full of data on ncpfs with 2.4.17, 
or 4GB file with few patches here...
