Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQJ3Mqz>; Mon, 30 Oct 2000 07:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbQJ3Mqp>; Mon, 30 Oct 2000 07:46:45 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:46092 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129091AbQJ3Mqh>;
	Mon, 30 Oct 2000 07:46:37 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linux Kernel Developer <linux_developer@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17 
In-Reply-To: Your message of "Mon, 30 Oct 2000 13:00:06 BST."
             <20001030130006.B1555@werewolf.cps.unizar.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Oct 2000 23:46:30 +1100
Message-ID: <3626.972909990@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 13:00:06 +0100, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>And what about struct fields ? It is the same. If you change the name of a field
>permanently, you have to modify the C source that uses it. But names are not
>important for binary compatability, so you can make things like:
>struct data {
>	int field1;
>#ifndef __cplusplus
>	double 	new;
>	int	class;
>#else
>	double	dnew;
>	int	klass;
>#endif
>};

Names *are* important for binary compatibilty on modules.  If you
compile with symbol versions, the field names within a structure are
included in the checksum that is generated for the overall structure.
If you declare different names depending on compile time options then
genksyms says that they are different structure definitions, you will
get a mismatch on the checksum of exported symbols and will not be able
to load the modules.

There is also the less important problem of confusing debuggers.  The
data that is saved when you compile with -g will be different in
various modules, a possible source of confusion.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
