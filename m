Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129349AbQKNMRb>; Tue, 14 Nov 2000 07:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130918AbQKNMRV>; Tue, 14 Nov 2000 07:17:21 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:5644 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129349AbQKNMRJ>;
	Tue, 14 Nov 2000 07:17:09 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Schleef <ds@stm.lbl.gov>
Date: Tue, 14 Nov 2000 12:47:40 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: More modutils: It's probably worse.
CC: Michal Zalewski <lcamtuf@DIONE.IDS.PL>, BUGTRAQ@SECURITYFOCUS.COM,
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <CD314F06B1A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Nov 00 at 2:04, David Schleef wrote:
> On Tue, Nov 14, 2000 at 09:59:22AM +0100, Olaf Kirch wrote:
> > On Tue, Nov 14, 2000 at 12:06:32AM +0100, Michal Zalewski wrote:
> > > Maybe I am missing something, but at least for me, modprobe
> > > vulnerabilities are exploitable via privledged networking services,
> > > nothing more.
> > 
> > Maybe not. ncpfs for instance has an ioctl that seems to allow
> > unprivileged users to specify a character set (codepage in m$speak)
> > that's requested via load_nls(), which in turn does a

> Then it looks like the driver is broken, not modutils.

Well, you can use this ioctl only before ncp filesystem gets to life,
but yes, as this call is always done by mount process, I'll add

if (!capable(CAP_SYS_ADMIN))
  return -EPERM;

here. But I still do not see any problem, as ncpfs limits charset/codepage
length to 20 chars (+ NUL terminator), and nobody told me that it is
not possible to use " or - in codepage name ;-)
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
