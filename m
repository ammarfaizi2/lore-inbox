Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSEONgx>; Wed, 15 May 2002 09:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314684AbSEONgw>; Wed, 15 May 2002 09:36:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45836 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S314396AbSEONgv>;
	Wed, 15 May 2002 09:36:51 -0400
Date: Wed, 15 May 2002 08:36:45 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Device driver question
Message-Id: <20020515083645.7320aefa.reynolds@redhat.com>
In-Reply-To: <180577A42806D61189D30008C7E632E87938E1@boca213a.boca.ssc.siemens.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.7.6cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered "Bloch, Jack" <Jack.Bloch@icn.siemens.com>, spoke thus:

> I have a specific case where our HW can generate a
>  special interrupt. In this case I simply want the ISR to halt the system
>  (i.e. take the same action as if I typed halt from the command line). How
>  can I from within my device driver cause a halt? Please CC me specifically
>  on any replies.

Check out the code for "sys_reboot" in "kernel/sys.c" for ideas on how to do
this.  I don't think you can invoke "sys_reboot" from inside an interrupt
handler, but you could probably do the same thing by calling the service
routines "sys_reboot" does.

If that doesn't shut your machine down gracefully, then you might resort to
"call_usermodehelper" in "kernel/kmod.c" to run "/sbin/shutdown -h now".  You
can't invoke "call_usermodehelper" from an interrupt top half, but it should
work find from a tasklett.
