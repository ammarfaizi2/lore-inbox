Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSLZXXv>; Thu, 26 Dec 2002 18:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSLZXXv>; Thu, 26 Dec 2002 18:23:51 -0500
Received: from smtp04.iddeo.es ([62.81.186.14]:3014 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id <S264653AbSLZXXt>;
	Thu, 26 Dec 2002 18:23:49 -0500
Date: Thu, 26 Dec 2002 23:46:56 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre on SMP-HT exports bad AT_PLATFORM
Message-ID: <20021226224656.GC1563@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi all...

Continuing with the glibc-2.3.1 saga, I have tested 2.4.21-pre2. It also
fails. glibc can not get a correct AT_PLATFORM when the kernel is run
on an hyperthreaded smp box.

I have run this on the box (dual P4@1.8GHz). Highmem does not matter. Just
HT matters. If I sun the SMP kernel with HT active, it glibc fails to detect
AT_PLATFORM. If I disable HT, from the bios or with 'noht' boot option, the
platform is correctly detected. Something does not follow the rules in
binfmt_elf.c when there are siblings (not real CPUs) in the game. Or there
is gcc-3.2.1 to blame.

Test script:
#!/bin/bash

#log=$(uname -r).txt
log=log.txt

exec > $log 2>&1

echo ===== uname -a
uname -a
echo
echo ===== uname -m
uname -m
echo
echo ===== ./ld.so
./ld.so
echo
echo ===== LD_LIBRARY_PATH="" LD_DEBUG=libs /bin/true
rm -f /etc/ld.so.cache
LD_LIBRARY_PATH="" LD_DEBUG=libs /bin/true
echo
ldconfig

ld.so is a modified one to print AT_PLATFORM, by Gwenole@mandrakesoft. The
loader used for the /bin/true test is the standard one.

Results for 2.4.21-pre2 are attached. All are smp kernels, 'ht' means ht active,
'noht-bios' is ht diabled in the bios and 'noht-soft' is ht disabled with 'noht'.

Any ideas ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))

--zx4FCpZtqtKETZ7O
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="2.4.21-pre2-ht.txt.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWQaRzKQAAXf/gCA0BABI5/f7P+feav//3/BQBCIsTWLZQFAlEagVPyp/op6a
aNUeo02hqep6jTTaelD0Q9TxNqgBoQ0NRkmJooMno1NAyGCYEwEDJgkSBNJkam0pPDTRTRiZ
NA9Q0aDQDCeQ4yZMmIxMAJkwTIAaMIwBDAcZMmTEYmAEyYJkANGEYAhguC+4QGVCm34N/OX1
w0+EGmeosoOEx/ZmFUjDy8YZNshxpVf1O59wIf2vzpWoUJZUiSZ8jggXZSClrpt2nFhZS7NR
Q/gLmbRUbV1+uKPmuJrnt1nRmZ7Qm7OFmFq+zpkNmZ9Xi9yXGxEZm6BhIK0XgzMV2slc/Gw8
GtY1JNUgHG8ZCvjcszONAaHLIWrbMzIIESKRsDJrtPQuM1cGnSei4IlZRXR/4tCVGfay5EWw
F1zfANZjYUPid4XFjojnhM+YPH1btzdqLkz8zVYqKYuo1QdPrz2iDLL6LA0iDz/rFee/pth7
a1flnIiIIiE4bbb9C1e5w7qJMbgcOIbG2JNvaqAR+P2JIhJH3vZ6r1lAhwkjdGE1KPzhBaPc
S7kkfQdlcUketJHp7b9uZZ8EFctj080JaI7Q7XAaXgWh0/jqv0clN/zEl++87OdcJEepw5PO
KsQIam5UsJGeDnFUaQ8qSkY41z17KcdUVGO8filP5FHDPMNeKuwiHCCUFwwzKRRNRedbK5Qm
4IqapMqYGWIrXR7VDWbOgVL264ySQkXc+9BLwc2hxKqh08MAkTXf4VRIkFof85fc0C7mI//0
KNV7RQLM24CNeqf9lY4cyi5F5s66GEkKbq4YMtIhNy9SHFZtRET5zVuNR7HrM8GSOkhc8oOi
0SdcpTVJAHKCcMHA0iolhGwc/pT/IxtEogu+2JFtqnogRGJiSW4plZCBEajBkkemmpyCdMQl
NlqgrtkhGsz5bCwdbEcmsWpkIXKRLFCzNExz2KREoBOEotKF42Mc4ximla7QQbmLXhzFbDGX
rNJd9jywJ8L32W3NykUR75yzvQMfIDDNmGl9CIwYkKuxD7S9Jui5+ebZPNy6Lv/Hncuxg2If
XNID12XBwzEcu+MizRB0OSWc92CeEkFKKIarx6YkczK5iU6iU/JpfyxPCJsnRjhQW42qyjCB
xNtiCjZafip4ydKVLDJjIZl0miGhcwYnJrV70LqHVrsxhwdhsfCNTzj5SNL9GZkp6JTmJZb6
JN62A+RC4cUTCrPmvqSUnJq5nWiFhqsM7Kaui6hKRu5ZSwY0Nk2R7oIWesGfd1G8BbQzlscS
T3CIpvHsgAPcACoISFBnXznCgfiF0vggYlIOxoYMkRgGUJDYFrTwLUVX5MM1JK+zqYYaJUNG
QwsA/FkLE7NvHM6dLyLLbvtSRPechKouL0wyYT3TQcdirqZnxF3JFOFCQBpHMpA=

--zx4FCpZtqtKETZ7O
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="2.4.21-pre2-noht-bios.txt.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWQtmfbQAAdl/gGA0BABI5/97P+feav//3/BQBGIsesZnbZJhUJRCaTU8noap
6BTymR5E9TaRoNqDGgZHlACU1J6CaCaNNKHlDJ6jQAAAAADQM0khNDVPSPSPTUPKAGgAAGgB
oAcZMmmmEyMgYEYmjBGEGjTAAIJIiYSbUmnko0bU/SgAAGnoIDQAHqdGUP7lRAeqFeTmd6W9
N2rZU6Zqi3gYiYutzhVHh49cMnVKeFKr5TsblBD1jfSKhQllQEvFiYEDLjIKYWTd+rfuspZm
oobuFzO+tR1Lr4JH15CbI12k+eZzXQm/Giy7Cvy0SnpyfFzXZDUqgJKyKIRlWbiSMeXSVj53
LZW+qk0OSgWJzQx/mqVqU8BQVNC+V9qTECEJwncVhxvW6WdsrCtuFu7UQhjSct3POsaYVe+s
tAOmS42vErdnc0Z1DHxsn+lEN5t4Nnx7u535RcWeLqrKKZOI1QZPrz4UQct74WC420ZfTO+P
vpp5zDNdcHZqKSKSMgAByyAAAAG993hOAhUoQQhnRCiEgIKISMAYAAAEhCGp3pJT0+JJPakn
57MFp59E4OANwwAT1cBRDz3R6HEUcQv0hJlWppvTc0n3t+G/QrjWkQzU1KNdJSi1PHRja7oB
zMQNLQMAZ+3Rz8dqm3WJe7Np9uBbpUaputaeCuIEOR1tLhHnQxhU9IeNJSON0Z466cFUlGCs
579+2VjSyY3qyDYyjSRl8pI1PRJVeVrCeGCSZox6aZcaXGOQiu3T4mDkOXuDLdHwSKTJt0w3
IW4Hj4XKMna7fQIEV/t8kQIBN26cP4yEL++NPiucTiwLcqRlsj9CT6+FTFTGwt1yzU07F5BI
WFKMK9bRL7Dklti1hNaNBrsv8KltUeyouLCUX6asPBJwSa5RJWSQGZFw5N7f5nPYNdgvnpFl
pquvxZkWlIX7IbboxSaR973o3FbswcrbIe2d+kXBbNFKwM9BMOwyRmyzjsom91Ks7TyXAxFt
DpSokyNzCo+uIQ8Kw++Qw09dKZDMNrQ23TMlMQi6TgHPg7bWeOb3X66+sCZzW03PAqvUIrXI
6L4MyEUMbMxcpbFy57dtgVsitmJ9jLFYiEgbRus00/dg+Egs6K/s0rAai4im8raszM1NK65y
Dv6W2UuaK/JJp5Aw/Nlb2YPSDoeKFBoE+E5IiggKDpJmCKRN9I8R4xkTEOIgi/pGTCGbWFTq
Js1sYbeNJltvdnNpobW+R5Bs4GqvWsYKOpKMRLDG5JmymAdVC17ERCTHdrkQUGgyqWlchUyV
LTUVVFU4EDgzwhRhkMxFh+246tk5bk4zEBGkLQ0QT17wBWJx3AG0BFi6hY1y31usRyJcUbnL
1JFlYlEWEKBfBmEgJzehOLSXYpg1gFt29BTJK41MOwTAG6mArzbp2WOvqrAmtOM7oEcTMESG
4LKl6B9TjHC5pZmB/xdyRThQkAtmfbQ=

--zx4FCpZtqtKETZ7O
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="2.4.21-pre2-noht-soft.txt.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWYIscQUAAdl/gGA0BABI5/97P+feav//3/BQBGLWx5hZK7agAlEJkU2noKn6
BTygeKeKeoNDbUhhHqeR5UANU9GhNqCE/VNomEaADATRgBGQADNKI0I1Taj0T1PUPUGgaBka
ANAAAHGTJpphMjIGBGJowRhBo0wACCSIJoNRoyUxlPTUAAAA0ADQMn2zh150QHqhVm+Dv5d2
X7+6l0zVFlBiJk73OFUeHj3xzdsDwoVf1gY3OCH9rwpWoTpZSBDXkYETPlIqY2Tfnf5L7KGa
J528xdDt1J2rw88j6sxNma7aerQ5rozdOqy/Gvp1QGWmc5iotVIkABES2EFMajjBEQnuVWrO
EhcSSoTYp18EqFVwLnfvevxC2aIYcC036cQaiktLaFlOHSdFsHtWEfM+ikFKnjc2j9cjI5kO
VG1QBaDeh5sCSQkiY6kY+uzBsnj0NlDu83Hi74ouTTW6myeiTWb4swcNONEHLL5bBcTaM/nk
+Lwpp5FsLrg7dIpIpIyAAH4kAAAAOs+/vmohSUEEIZIhQhICChCRgDAAAAkIQ3neklPRxpJx
JPzGftunBwBnAWL0iHjjD3OIo4hftCTENCEvOAuE7wFMBeHhbwqWNmDO18EPBs4A8GjBX3Wx
kyB0sQNzQMYavxr6tlynK0SX78j3+hb4I1Tnc08FcRI73XUOEedjGFL0j40FA4514K7aMVMk
+Ko4YcN0GNLJjoqItrgNJGYSgrpeiQV5UscEcUkzRj09kMqXmWQrXlt3KHUdekVLXbHksCC8
W2oJaDHbWEqoxZP9KDRy6OmaIEAsdvrh/WQhf7vp9a5hOLAr60jLdH7k3z57mKmNRbrlhRp1
LyCQrUUYU9TRL6jkldi1hNaNBrqv8Ki2qPZSLpWlC/TSo7JOCTX5EEJsBkSiHDaulROYV9W+
2ySbZpvw0JMWlHw1vnfKSTTOe56NxV4QctrkPXfdoFprvRS2BvvLA6rJG8eQ6qJvdRUyaea1
MRXQ6KUiTI3LUj4RA0XufnxEKzVSmIkLUws9mROwYYvnEA6KxWaNkDklqJnADh1vjoNQQswI
IlMVzmiiIEIxOuAK4H3VLnt21BVzKbMT7GeKxEJA2jdVpp+2z3yCuGh0PgWMhzjaCVY6aJqQ
QSkndlPdyPA1MTqDVb0mq9zVj3ZXCVFW4RHFbqWvFcJREqA2iTMWR2S7BGUplgxEYdjDkMUM
JaguN7LJtaFtGmy5bnZzlL2zfI8A2+Bjbx1MFHFKMRLDXJJmysAOohZ7kRCbHZtyIKDQZWlZ
yQqZKlbFFWotTgQNO/CFGGQzEWH67jquTlfRtNYCNAVhfBPb2gC2JtkAcoCKkqFTOfTbKpHI
nxRk5cpohdIoxAegYOkMwFlkaFklNu1SqgBbftYKYpSMWHYLABtmArjl0bqnJjbAsWjXZKBH
WbwRMW5saYMEdMRG69TyKn/F3JFOFCQgixxBQA==

--zx4FCpZtqtKETZ7O--
