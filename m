Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbSJDR12>; Fri, 4 Oct 2002 13:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSJDR12>; Fri, 4 Oct 2002 13:27:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39887 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262750AbSJDR10>;
	Fri, 4 Oct 2002 13:27:26 -0400
Importance: Normal
Sensitivity: 
Subject: 
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFDC2DE653.1C7A65EB-ON87256C48.005D6575@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Fri, 4 Oct 2002 12:32:22 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/04/2002 11:32:53 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Oct 04, 2002  16:35 +0100, David Howells wrote:
>
> > NFSv4 does indeed require the full kerberos encryption stuff in the
> > kernel. The RFC specifies that krb5 support is a minimum requirement
> > will expect to have that in 2.6 (or 3.0 or whatever it's called these
> > days...)
>
> Might this be something I can make use of for my AFS filesystem too?

>We will also need kerberos for Lustre when we start implementing
>security.  We will be using the GSSAPI for security, so basically
>the same as what AFS is using.
>
>Cheers, Andreas

The CIFS VFS (http://cifs.bkbits.net/linux-2.5) can get by with
just the kerberos service ticket encapsulation routines (negTokenInit,
negTokenTarg ala SPNEGO/GSSAPI) in kernel, and I have made a start
coding the cifs version of that since it will be a big benefit when
mounted to Samba 3.0 and this is almost required for decent Windows
2000 and .Net server security interoperability.  It would be useful
to come up with a generalized way to request new & refresh
expired service tickets - perhaps from a pam/nss daemon something
like what the current version of the Winbind daemon does now. In the
interim, raw (i.e. non-SPNEGO encapsulated) NTLMSSP (or NTLM ala older
clients) is used in the CIFS VFS.  Having a common call to get
at the kerberos tickets for a particular uid would be very helpful,
otherwise each remote filesystem might eventually code a different
IPC to a different user space mount or pam/nss helper
(e.g. Winbind for CIFS) to aquire a kerberos ticket that is opaque to
the particular filesystem.


Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


