Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289020AbSAZEsD>; Fri, 25 Jan 2002 23:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289021AbSAZErx>; Fri, 25 Jan 2002 23:47:53 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:14602 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S289020AbSAZErn>; Fri, 25 Jan 2002 23:47:43 -0500
Date: Sat, 26 Jan 2002 05:47:40 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Really odd behavior of overlapping named pipes?
Message-ID: <20020126054740.A30571@devcon.net>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020126021610.YKAU20810.femail29.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020126021610.YKAU20810.femail29.sdc1.sfba.home.com@there>; from landley@trommello.org on Fri, Jan 25, 2002 at 01:13:58PM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 01:13:58PM -0500, Rob Landley wrote:
> 
> int pipes[2];
> 
> pipe(pipes)
> dup2(pipes[0],0);
> close(pipes[0]);
> 
> Boom: the pipe is no longer usable.  The stdin instance of it is closed too.  
> Read from it you get an error.  (But if I DON'T close it, I'm leaking file 
> handles, aren't I?  AAAAAAAAH!)

Did you close stdin before the pipe()? If so, the read end of the pipe
will get descriptor 0, the dup2() has actually no effect, and with the
close() you just closed stdin again.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
