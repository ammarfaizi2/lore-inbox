Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281645AbRLICMi>; Sat, 8 Dec 2001 21:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281561AbRLICMa>; Sat, 8 Dec 2001 21:12:30 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:57033 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S281558AbRLICMV>; Sat, 8 Dec 2001 21:12:21 -0500
Date: Sat, 8 Dec 2001 18:12:18 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: (Patch) Please name parameters in function declarations
Message-ID: <20011208181218.A31209@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	In trying to understand the new bio interface and other
kernel features, it dawns on me that I would be able to learn this
stuff faster and be less likely to make as many mistakes if the
declarations of function pointers and even external functions included
names for any parameters whose exact semantics was not absolutely
obvious.  For example, one has to open another file when looking
at blkdev.h to figure out the meaning of:

extern int end_that_request_first(struct request *, int, int);

	At least here, one can flip back to the source code for each
external routine in question (and there might be many), but, in the
case of function pointers, you can only look at how the function pointers
are used and the drivers that implement them, which is an easy way for
misunderstanding to arise.  Just for illustration, here is one example
from fs.h:

struct address_space_operations {
	...
	int (*direct_IO)(int, struct inode *, struct kiobuf *, unsigned long, i\
nt);
};

	I understand the dangers of verbosity, and I'm not advocating
naming every parameter or having length names.  However, I do think that
naming parameters when the name can help clarify things will save
verbosity in the form of reduced documentation needs, save author
and reader time as a result of fewer questions, and may even improve
the quality of the software that people write to these interfaces.

	Therefore, I humbly request the following small addition to
linux-2.5.1-pre7/Documentation/CodingStyle.  I'm happy to submit
patches for specific problems along these lines that I find, but I'd
like to try to improve the situation at the source by adding this
three sentence paragraph of chapter 4 (Functions) of
Documentation/CodingStyle.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="style.diff"

--- linux-2.5.1-pre7/Documentation/CodingStyle	Sun Sep  9 16:40:43 2001
+++ linux/Documentation/CodingStyle	Sat Dec  8 17:54:50 2001
@@ -142,6 +142,12 @@
 it's performance-critical, and it will probably do a better job of it
 that you would have done). 
 
+In header files, use simple descriptive names for parameters of
+functions and function pointers when the meaning of a parameter is
+not absolutely postively clear.  This probably includes every
+parameter of type "int."  This is an easy and quickly accessible
+form of interface documentation.
+
 Another measure of the function is the number of local variables.  They
 shouldn't exceed 5-10, or you're doing something wrong.  Re-think the
 function, and split it into smaller pieces.  A human brain can

--VbJkn9YxBvnuCH5J--
